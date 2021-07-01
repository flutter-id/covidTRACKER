<?php

namespace App\Http\Resources;

use Illuminate\Support\Str;
use Illuminate\Http\Resources\Json\JsonResource;

class StatusResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array
     */
    public function toArray($request)
    {
        // dd($request);
        return [
            'id'            => $this->id,
            'date'          => $this->date,
            'name'          => $this->name,
            'occupation'    => $this->occupation,
            'institution'   => $this->institution,
            'type'          => $this->type->name,
            'status'        => $this->status
        ];
    }
}
