<?php

namespace App\Http\Controllers;

use App\Models\User;
use Ramsey\Uuid\Uuid;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use App\Http\Resources\UserResource;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;

class UserController extends Controller
{
    public function check(Request $request)
    {
        if (Auth::guard('api')->check()) {
            return response()->json([
                'success'   => true,
                'message'   => 'active',
                'data'      => null
            ],200);
        } else {
            return response()->json([
                'success'   => false,
                'message'   => 'inactive',
                'data'      => null
            ],401);
        }    
    }
    public function register(Request $request)
    {
        $validation = Validator::make($request->all(),
            [
                'name'          => 'required',
                'email'         => 'required|email|unique:users',
                'password'      => 'required|min:8|confirmed',
                'photo'         => 'nullable|file|image|max:512',
                'gender'        => 'required|in:Male,Female',
                'birth_place'   => 'nullable|max:255',
                'birth_date'    => 'required|date',
                'occupation'    => 'nullable|max:255',
                'address'       => 'required|max:255',
                'village_id'    => [
                    'required',
                    Rule::exists('villages','id',$request->village_id),
                ]
            ]
        );
        if($validation->fails())
        {
            return response()->json($validation->errors(),400);
        }

        $id = Uuid::uuid6();
        $data = [
            'id'            => $id,
            'name'          => $request->name,
            'email'         => $request->email,
            'password'      => Hash::make($request->password),
            'gender'        => $request->gender,
            'birth_place'   => $request->birth_place,
            'birth_date'    => $request->birth_date,
            'occupation'    => $request->occupation,
            'address'       => $request->address,
            'village_id'    => $request->village_id,
        ];

        if($request->file('photo')){
            $image = $request->file('photo');
            $image->storeAs('public/user',$image->hashName());    
            $data['image'] = $image->hashName();
        }
        $result = User::create($data);

        return response()->json(
            [
                'success'   => true,
                'message'   => 'Registration Successfully',
                'data'      => $data,
                'token'     => $result->createToken('authToken')->accessToken
            ],201
        );
    }

    public function profile()
    {
        $profile = User::with(['village','village.district','village.district.regency','village.district.regency.province'])->find(auth()->user()->id);
        return response()->json([
            'status'    => true,
            'message'   => 'Show Data',
            'data'      => new UserResource($profile)
        ],200);
    }

    public function update(Request $request)
    {
        $user = Auth::user();
        $validation = Validator::make($request->all(),
            [
                'name'          => 'required',
                'email'         => 'required|email|unique:users,id,'.$user->id,
                'password'      => 'nullable|min:8|confirmed',
                'photo'         => 'nullable|file|image|max:512',
                'gender'        => 'required|in:Male,Female',
                'birth_place'   => 'nullable|max:255',
                'birth_date'    => 'required|date',
                'occupation'    => 'nullable|max:255',
                'address'       => 'required|max:255',
                'village_id'    => [
                    'required',
                    Rule::exists('villages','id',$request->village_id),
                ]
            ]
        );
        if($validation->fails())
        {
            return response()->json($validation->errors(),400);
        }

        $data = [
            'name'          => $request->name,
            'email'         => $request->email,
            'gender'        => $request->gender,
            'birth_place'   => $request->birth_place,
            'birth_date'    => $request->birth_date,
            'occupation'    => $request->occupation,
            'address'       => $request->address,
            'village_id'    => $request->village_id,
        ];

        $image = $request->file('photo');
        if($image){
            Storage::disk('local')->delete('public/user/',basename($user->photo));
            $image->storeAs('public/user',$image->hashName());
            $data['photo'] = $image->hashName();
        }

        if($request->password){
            $data['password'] = Hash::make($request->password);
        }

        $user->update($data);
        return response()->json(
            [
                'success'   => true,
                'message'   => 'Updated Successfully',
                'data'      => $user,
            ],200
        );
    }

    public function login(Request $request)
    {
        $validation = Validator::make($request->all(),
        [
            'email'         => 'required|email',
            'password'      => 'required|min:8'
        ]);
        
        if($validation->fails())
        {
            return response()->json($validation->errors(),400);
        }

        $result = User::where('email',$request->email)->first();
        if(!$result || !Hash::check($request->password, $result->password))
        {
            return response()->json([
                'success'   => false,
                'message'   => 'Login Failed'                
            ],401);
        }
        return response()->json([
            'success'   => true,
            'message'   => 'Login Successfully',
            'data'      => $result,
            'token'     => $result->createToken('authToken')->accessToken
        ],200);
    }

    public function logout(Request $request)
    {
        if(auth()->user())
        {
            $result = $request->user()->tokens()->delete();
            if($result)
            {
                return response()->json([
                    'success'   => true,
                    'message'   => 'Logout Succesfully'
                ],200);
            }    
        }else{
            return response()->json([
                'success'   => false,
                'message'   => 'Unauthorized'
            ],401);
        }
    }
}
