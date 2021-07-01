<?php

namespace Database\Seeders;

use App\Models\Type;
use App\Models\User;
use App\Models\Status;
use Illuminate\Database\Seeder;
use Faker\Factory as Faker;

class StatusTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $faker = Faker::create();
        Status::create([
            'id'            => $faker->uuid(),
            'user_id'       => User::where('email','admin@admin.com')->pluck('id')->first(),
            'date'          => $faker->date(),
            'name'          => $faker->name,
            'occupation'    => 'Doctor',
            'institution'   => $faker->streetName(),
            'type_id'       => Type::all()->random(1)->pluck('id')->first(),
            'status'        => 'Positive',
            'description'   => $faker->paragraph(1)
        ]);
        Status::create([
            'id'            => $faker->uuid(),
            'user_id'       => User::where('email','admin@admin.com')->pluck('id')->first(),
            'date'          => $faker->date(),
            'name'          => $faker->name,
            'occupation'    => 'Nurse',
            'institution'   => $faker->streetName(),
            'type_id'       => Type::all()->random(1)->pluck('id')->first(),
            'status'        => 'Negative',
            'description'   => $faker->paragraph(1)
        ]);
    }
}
