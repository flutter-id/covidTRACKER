<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Province;
use App\Models\Regency;
use App\Models\District;
use App\Models\Village;

class WilayahController extends Controller
{
    public function province(){
        $provinces = Province::all();
        return response()->json([
            'success'   => true,
            'message'   => 'List of Data',
            'data'      => $provinces
        ],200);
    }

    public function regency($id){
        $regencies = Regency::where('province_id',$id)->get();
        return response()->json([
            'success'   => true,
            'message'   => 'List of Data',
            'data'      => $regencies
        ],200);
    }

    public function district($id){
        $districts = District::where('regency_id',$id)->get();
        return response()->json([
            'success'   => true,
            'message'   => 'List of Data',
            'data'      => $districts
        ],200);
    }

    public function village($id){
        $villages = Village::where('district_id',$id)->get();
        return response()->json([
            'success'   => true,
            'message'   => 'List of Data',
            'data'      => $villages
        ],200);
    }
}
