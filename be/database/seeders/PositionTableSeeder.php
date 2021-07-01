<?php

namespace Database\Seeders;

use App\Models\User;
use App\Models\Position;
use Illuminate\Database\Seeder;
use Faker\Factory as Faker;

class PositionTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $faker = Faker::create();
        for($i=0;$i<50;$i++){
            Position::create([
                'id'        => $faker->uuid,
                'user_id'   => User::where('email','admin@admin.com')->pluck('id')->first(),
                'datetime'  => $faker->dateTime(),
                'latitude'  => $faker->latitude(),
                'longitude' => $faker->longitude()
            ]);    
        }
    }
}
