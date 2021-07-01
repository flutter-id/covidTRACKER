<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Database\Seeders\UserTableSeeder;
use Database\Seeders\CategoryTableSeeder;
use Database\Seeders\TypeTableSeeder;
use Database\Seeders\PostTableSeeder;
use Database\Seeders\StatusTableSeeder;
use Database\Seeders\PositionTableSeeder;
use Database\Seeders\IndoRegionSeeder;



class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
		$this->call([
            IndoRegionSeeder::class,
            UserTableSeeder::class,
            CategoryTableSeeder::class,
            TypeTableSeeder::class,
            PostTableSeeder::class,
            StatusTableSeeder::class,
            PositionTableSeeder::class
        ]);
		$this->command->info('All table Seeded Successfully!');
    }
}
