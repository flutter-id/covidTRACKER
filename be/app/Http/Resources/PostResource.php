<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class PostResource extends JsonResource
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
            'category_name' => $this->category->name,
            'user'          => $this->user->name,
            'image'         => str_contains($this->image,'/') ? $this->image : asset('storage/post/'.$this->image),
            'title'         => $this->title,
            'slug'          => $this->slug,
            'description'   => $this->description,
            'summary'       => $this->summary,
            'content'       => $this->content,
            'status'        => $this->status,
            'featured'      => $this->featured ? true : false
        ];
    }
}
