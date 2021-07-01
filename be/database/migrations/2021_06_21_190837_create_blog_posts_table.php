<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateBlogPostsTable extends Migration {

	public function up()
	{
		Schema::create('blog_posts', function(Blueprint $table) {
			$table->uuid('id');
			$table->uuid('category_id')->index();
			$table->uuid('user_id')->index();
			$table->text('image');
			$table->string('title', 255);
			$table->string('slug', 255)->unique();
			$table->string('description', 255)->nullable();
			$table->text('summary');
			$table->text('content');
			$table->enum('status', array('Draft', 'Publish'))->index();
			$table->boolean('comments')->nullable()->index();
			$table->boolean('featured')->index();
			$table->timestamps();
			$table->softDeletes();
		});
	}

	public function down()
	{
		Schema::drop('blog_posts');
	}
}