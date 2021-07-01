<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class UserResource extends JsonResource
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
            'id'            => $this->id,
            'name'          => $this->name,
            'email'         => $this->email,
            'photo'         => $this->photo,
            'gender'        => $this->gender, 
            'birth_place'   => $this->birth_place, 
            'birth_date'    => $this->birth_date, 
            'occupation'    => $this->occupation, 
            'address'       => $this->address,
            'village_id'    => $this->village_id, 
            'district_id'   => $this->village->district_id, 
            'regency_id'    => $this->village->district->regency_id, 
            'province_id'   => $this->village->district->regency->province_id
        ];
    }
}
