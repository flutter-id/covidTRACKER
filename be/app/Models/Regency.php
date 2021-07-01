<?php

/*
 * This file is part of the IndoRegion package.
 *
 * (c) Azis Hapidin <azishapidin.com | azishapidin@gmail.com>
 *
 */

namespace App\Models;

use AzisHapidin\IndoRegion\Traits\RegencyTrait;
use Illuminate\Database\Eloquent\Model;

/**
 * Regency Model.
 */
class Regency extends Model
{
    use RegencyTrait;

    /**
     * Table name.
     *
     * @var string
     */
    protected $table = 'regencies';

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'province_id'
    ];

    /**
     * Regency belongs to Province.
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function province()
    {
        return $this->belongsTo(Province::class);
    }

    /**
     * Regency has many districts.
     *
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function districts()
    {
        return $this->hasMany(District::class);
    }

    public function villages()
    {
        return $this->hasManyThrough(Villlages::class,District::class);
    }

    // public function villages()
    // {
    //     return $this->hasManyThrough(
    //         Village::class,
    //         District::class,
    //         'regency_id',
    //         'district_id',
    //         'id',
    //         'id'
    //     );
    // }

    // public function users()
    // {
    //     return $this->hasManyThrough(
    //         User::class,
    //         Village::class,
    //         District::class,
    //         'regency_id',
    //         'district_id',
    //         'village_id',
    //         'id',
    //         'id',
    //         'id'
    //     );
    // }

}
