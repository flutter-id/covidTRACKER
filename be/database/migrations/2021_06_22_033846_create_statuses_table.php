<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateStatusesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('statuses', function (Blueprint $table) {
            $table->uuid('id');
            $table->uuid('user_id')->index();
            $table->date('date');
            $table->string('name',100);
            $table->enum('occupation',['Medical Person','Nurse','Doctor','Other']);
            $table->string('institution',100);
            $table->uuid('type_id')->index();
            $table->enum('status',['Positive','Negative']);
            $table->string('description')->nullable()->default(null);

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('statuses');
    }
}
