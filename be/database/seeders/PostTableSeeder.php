<?php

namespace Database\Seeders;

use App\Models\Post;
use App\Models\User;
use App\Models\Category;
use Faker\Factory as Faker;
use Illuminate\Support\Str;
use Illuminate\Database\Seeder;

class PostTableSeeder extends Seeder {

	public function run()
	{
		$faker = Faker::create();
		for($i=0;$i<10;$i++){
			$title = $faker->sentence(5);
			Post::create(array(
				'id'			=> $faker->uuid(),
				'category_id' 	=> Category::all()->random(1)->pluck('id')->first(),
				'user_id'		=> User::where('email','admin@admin.com')->pluck('id')->first(),
				'image'       	=> $faker->imageUrl(640, 480, 'animals', true),
				'title' 		=> $title,
				'slug' 			=> Str::slug($title),
				'description' 	=> $faker->paragraph(1),
				'summary'     	=> $faker->paragraph(1),
				'content'     	=> $faker->paragraph(5),
				'status'      	=> 'Publish',
				'comments'      => 0,
				'featured'      => 1
			));
		}
	}
}