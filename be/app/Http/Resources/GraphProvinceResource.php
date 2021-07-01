<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class GraphProvinceResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array
     */
    public function toArray($request)
    {
        return [
            'province'      => $this->name,
            'regencies'     => $this->regencies->count(),
            'districts'     => $this->districts->count(),
            'villages'      => $this->villages->count(),
            // 'villages'      => $this->districts->transform(function($query){
            //     return $query->villages->count();
            // }),
            // 'users'         => $this->users->count(),
        ];
    }
}
