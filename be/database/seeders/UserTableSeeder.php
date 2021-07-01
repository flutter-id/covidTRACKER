<?php

namespace Database\Seeders;

use App\Models\User;
use App\Models\Village;
use Faker\Factory as Faker;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class UserTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $faker = Faker::create();
		User::create(array(
            'id'            => $faker->uuid(),
            'name'          => $faker->name(),
            'email'         => 'admin@admin.com',
            'password'      => Hash::make('12345678'),
            'gender'        => 'Male',
            'birth_place'   => $faker->city(),
            'birth_date'    => $faker->date(),
            'occupation'    => $faker->word(),
            'address'       => $faker->address(255),
            'village_id'    => Village::all()->random(1)->pluck('id')->first(),
        ));    
    }
}