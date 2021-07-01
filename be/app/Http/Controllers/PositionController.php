<?php

namespace App\Http\Controllers;

use Ramsey\Uuid\Uuid;
use App\Models\Position;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class PositionController extends Controller
{
    public function index()
    {
        $data = Position::all();
        return response()->json([
            'success'   => true,
            'message'   => 'List Data',
            'data'      => $data
        ],200);
    }

    public function store(Request $request)
    {
        $validation = Validator::make($request->all(),[
            'datetime'      => 'required|date',
            'latitude'      => 'required|max:255',
            'longitude'     => 'required|max:255'
        ]);

        if($validation->fails()){
            return response()->json($validation->errors(),400);
        }

        $id = Uuid::uuid6();
        $data = [
            'id'        => $id,
            'user_id'   => $request->user()->id,
            'datetime'  => $request->datetime,
            'latitude'  => $request->latitude,
            'longitude' => $request->longitude
        ];

        Position::create($data);
        return response()->json([
            'success'   => true,
            'message'   => 'Created Successfully',
            'data'      => $data
        ],201);
    }

    public function show(Position $position)
    {
        return response()->json([
            'success'   => true,
            'message'   => 'Show Data',
            'data'      => $position
        ],200);
    }
}
