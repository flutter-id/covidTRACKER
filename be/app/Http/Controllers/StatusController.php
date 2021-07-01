<?php

namespace App\Http\Controllers;

use Ramsey\Uuid\Uuid;
use App\Models\Status;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use Illuminate\Support\Facades\Validator;
use App\Http\Resources\StatusCollection;

class StatusController extends Controller
{
    public function index()
    {
        $find = Status::with(['type'])->where('user_id',auth()->user()->id)->get();
        // return response()->json([
        //     'status'    => true,
        //     'message'   => 'List Data',
        //     'data'      => $find
        // ],200);
        return new StatusCollection(true, 'List of Data', $find);
    }

    public function store(Request $request)
    {
                
        $validation = Validator::make($request->all(),[
            'date'          => 'required|date',
            'name'          => 'required|max:100',
            'occupation'    => 'required|in:Medical Person,Nurse,Doctor,Other',
            'institution'   => 'required|max:100',
            'type_id'       => [
                'required',
                Rule::exists('types','id',$request->type_id)
            ],
            'status'        => 'required|in:Positive,Negative',
            'description'   => 'nullable|max:255'
        ]);

        if($validation->fails()){
            return response()->json($validation->errors(),400);
        }

        $id = Uuid::uuid6();
        $data = [
            'id'            => $id,
            'user_id'       => $request->user()->id,
            'date'          => $request->date,
            'name'          => $request->name,
            'occupation'    => $request->occupation,
            'institution'   => $request->institution,
            'type_id'       => $request->type_id,
            'status'        => $request->status,
            'description'   => $request->description
        ];

        Status::create($data);
        return response()->json([
            'success'   => true,
            'message'   => 'Created Successfully',
            'data'      => $data
        ],201);        
    }

    public function show(Status $status)
    {
        return response()->json([
            'success'   => true,
            'message'   => 'Show Data',
            'data'      => $status
        ],200);
    }

    public function update(Request $request, Status $status)
    {
        $validation = Validator::make($request->all(),[
            'date'          => 'required|date',
            'name'          => 'required|max:100',
            'occupation'    => 'required|in:Medical Person,Nurse,Doctor,Other',
            'institution'   => 'required|max:100',
            'type_id'       => [
                'required',
                Rule::exists('types','id',$request->type_id)
            ],
            'status'        => 'required|in:Positive,Negative',
            'description'   => 'nullable|max:255'
        ]);

        if($validation->fails()){
            return response()->json($validation->errors(),400);
        }

        $status->update([
            'date'          => $request->date,
            'name'          => $request->name,
            'occupation'    => $request->occupation,
            'institution'   => $request->institution,
            'type_id'       => $request->type_id,
            'status'        => $request->status,
            'description'   => $request->description
        ]);

        return response()->json([
            'success'   => true,
            'message'   => 'Updated Successfully',
            'data'      => $status
        ],200);
    }

    public function destroy(Status $status)
    {
        if($status){
            $status->delete();
            return response()->json([
                'status'    => true,
                'message'   => 'Deleted Successfully',
                'data'      => null
            ],200);
        }

        return response()->json([
            'success'   => false,
            'message'   => 'Not Found',
            'data'      => null
        ],404);
    }
}
