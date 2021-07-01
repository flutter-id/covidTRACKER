<?php

namespace App\Http\Controllers;

use App\Models\Type;
use Ramsey\Uuid\Uuid;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class TypeController extends Controller
{
    public function index()
    {
        $data = Type::all();
        return response()->json([
            'success'   => true,
            'message'   => 'List Data',
            'data'      => $data
        ],200);
    }

    public function store(Request $request)
    {
        $validation = Validator::make($request->all(),[
            'name'          => 'required|unique:types|max:255',
            'description'   => 'nullable|max:255'
        ]);

        if($validation->fails()){
            return response()->json($validation->errors(),200);
        }

        $id = Uuid::uuid6();
        $data = [
            'id'            => $id,
            'name'          => $request->name,
            'description'   => $request->description
        ];

        Type::create($data);
        return response()->json([
            'success'       => true,
            'message'       => 'Created Successfully',
            'data'          => $data
        ],200);
    }

    public function show(Type $type)
    {
        return response()->json([
            'success'       => true,
            'message'       => 'List Data',
            'data'          => $type
        ],200);
    }

    public function update(Request $request, Type $type)
    {
        $validation = Validator::make($request->all(),[
            'name'          => 'required|max:255|unique:types,name,'.$type->id,
            'description'   => 'nullable|max:255'
        ]);

        if($validation->fails()){
            return response()->json($validation->errors(),400);
        }

        $type->update([
            'name'          => $request->name,
            'description'   => $request->description
        ]);

        return response()->json([
            'success'   => true,
            'message'   => 'Updated Successfully',
            'data'      => $type
        ],200);
    }

    public function destroy(Type $type)
    {
        if($type){
            $type->delete();
            return response()->json([
                'success'   => true,
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
