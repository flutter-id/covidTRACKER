<?php

namespace App\Http\Controllers;

use PDO;
use App\Models\Status;
use App\Models\Village;
use App\Models\District;
use App\Models\Province;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Eloquent\Builder;
use App\Http\Resources\GraphProvinceCollection;

class GraphController extends Controller
{
    public function province(){
        $province = Province::all();
        $positive = Status::with(['user.village.district.regency.province'])->where('status','Positive')->get();
        $result = [];
        foreach($province as $prov){
            $total = 0;
            foreach($positive as $pos){
                if($pos->user->village->district->regency->province->id == $prov->id){
                    $total++;
                }
            }
            if($total > 0){
                $result[] = ['id' => $prov->id,'name' => $prov->name,'total' => $total];
            }
        }
        return response()->json(
            [
                'success'   => true,
                'message'   => 'List of Date',
                'data'      => $result
            ]
        ,200);
    }
}
