<?php

namespace Database\Seeders;
use Faker\Factory as Faker;

use App\Models\Category;
use Illuminate\Support\Str;
use Illuminate\Database\Seeder;

class CategoryTableSeeder extends Seeder {

	public function run()
	{
		$faker = Faker::create();
		for($i = 0; $i < 5; $i++){
			$name = $faker->word();
			Category::create(array(
				'id'			=> $faker->uuid(),
				'name' 			=> $name,
				'slug' 			=> Str::slug($name),
				'description' 	=> $faker->sentence()
			));
		}
	}
}