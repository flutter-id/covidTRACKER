<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\ResourceCollection;
use App\Http\Resources\StatusResource;

class StatusCollection extends ResourceCollection
{
    /**
     * Transform the resource collection into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array
     */

    public $success, $message;

    public function __construct($success, $message, $data)
    {
        parent::__construct($data);
        $this->success = $success;
        $this->message = $message;
    }

    public function toArray($request)
    {
        return [
            'success'   => $this->success,
            'message'   => $this->message,
            'data'      => $this->collection->transform(function ($item){
                return new StatusResource($item);
            })
        ];
    }
}
