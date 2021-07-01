<?php

namespace App\Models;

use Illuminate\Support\Str;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Status extends Model
{
    use HasFactory;
    protected $primaryKey = 'id';
    protected $keyType = 'string';
    protected $guarded = [];
    
    public function type()
    {
        return $this->belongsTo(Type::class,'type_id');
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
