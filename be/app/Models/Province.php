<?php

/*
 * This file is part of the IndoRegion package.
 *
 * (c) Azis Hapidin <azishapidin.com | azishapidin@gmail.com>
 *
 */

namespace App\Models;

use AzisHapidin\IndoRegion\Traits\ProvinceTrait;
use Illuminate\Database\Eloquent\Model;
use Staudenmeir\EloquentHasManyDeep\HasRelationships;
/**
 * Province Model.
 */
class Province extends Model
{
    use ProvinceTrait;
    /**
     * Table name.
     *
     * @var string
     */
    protected $table = 'provinces';

    /**
     * Province has many regencies.
     *
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function regencies()
    {
        return $this->hasMany(Regency::class);
    }

    // public function districts()
    // {
    //     return $this->hasManyThrough(
    //         District::class,
    //         Regency::class,
    //         'province_id',
    //         'regency_id',
    //         'id',
    //         'id'
    //     );
    // }

    public function districts()
    {
        return $this->hasManyThrough(District::class,Regency::class);
    }

    // public function villages()
    // {
    //     return $this->hasManyThrough(
    //         Village::class,
    //         District::class,
    //         Regency::class,
    //         'province_id',
    //         'regency_id',
    //         'district_id',
    //         'id',
    //         'id',
    //         'id'
    //     );
    // }
    
    // public function villages()
    // {
    //     return $this->hasManyThrough(
    //         Village::class,
    //         District::class,
    //         Regency::class,
    //         'province_id',
    //         'id',
    //         'district_id',
    //         'id',
    //         'id',
    //         'id'
    //     );
    // }

    // public function villages()
    // {
    //     return $this->hasManyDeep(
    //         Village::class,
    //         [District::class,
    //         Regency::class]
    //     );
    // }
    // public function users()
    // {
    //     return $this->hasManyThrough(
    //         User::class,
    //         Village::class,
    //         District::class,
    //         Regency::class,
    //         'province_id',
    //         'regency_id',
    //         'district_id',
    //         'village_id',
    //         'id',
    //         'id',
    //         'id',
    //         'id'
    //     );
    // }

}
