<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Passport\HasApiTokens;

class User extends Authenticatable
{
    use HasFactory, Notifiable, HasApiTokens;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $guarded = [];
    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

    protected $primaryKey = 'id';
    protected $keyType = 'string';

    public function posts()
    {
        return $this->hasMany(Post::class,'user_id');
    }

    public function statuses()
    {
        return $this->hasMany(Status::class,'user_id');
    }

    public function positions()
    {
        return $this->hasMany(Position::class,'position_id');
    }

    public function village()
    {
        return $this->belongsTo(Village::class,'village_id');
    }
}
