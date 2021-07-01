<?php

namespace Database\Seeders;

use App\Models\Type;
use Faker\Factory as Faker;
use Illuminate\Database\Seeder;

class TypeTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $faker = Faker::create();
        Type::create([
            'id'            => $faker->uuid,
            'name'          => 'RNA/PCR',
            'description'   => $faker->words(5,true),
        ]);        
        Type::create([
            'id'            => $faker->uuid,
            'name'          => 'Antigen/Rapid',
            'description'   => $faker->words(5,true),
        ]);        
        Type::create([
            'id'            => $faker->uuid,
            'name'          => 'CLIA',
            'description'   => $faker->words(5,true),
        ]);        
        Type::create([
            'id'            => $faker->uuid,
            'name'          => 'Antibodi',
            'description'   => $faker->words(5,true),
        ]);        
    }
}
