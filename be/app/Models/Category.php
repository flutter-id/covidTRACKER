<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Category extends Model 
{

    protected $table = 'blog_categories';
    public $timestamps = false;
    protected $primaryKey = 'id';
    protected $keyType = 'string';
    protected $guarded = [];
    
    public function posts()
    {
        return $this->hasMany(Post::class,'category_id');
    }

}