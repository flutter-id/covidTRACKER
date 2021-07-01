<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateBlogCategoriesTable extends Migration {

	public function up()
	{
		Schema::create('blog_categories', function(Blueprint $table) {
			$table->uuid('id');
			$table->string('name', 255);
			$table->string('slug', 255)->unique();
			$table->string('description', 255)->nullable();
		});
	}

	public function down()
	{
		Schema::drop('blog_categories');
	}
}