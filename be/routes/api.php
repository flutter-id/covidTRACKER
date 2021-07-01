<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::get('check', [App\Http\Controllers\UserController::class, 'check'])->middleware(['auth:api']);
Route::post('register', [App\Http\Controllers\UserController::class, 'register']);
Route::post('login', [App\Http\Controllers\UserController::class, 'login']);
Route::post('logout', [App\Http\Controllers\UserController::class, 'logout'])->middleware(['auth:api']);
Route::get('profile', [App\Http\Controllers\UserController::class, 'profile'])->middleware(['auth:api']);
Route::post('update', [App\Http\Controllers\UserController::class, 'update'])->middleware(['auth:api']);
Route::group(['prefix' => 'category'], function(){
    Route::get('', [App\Http\Controllers\CategoryController::class,'index']);
    Route::get('{id}', [App\Http\Controllers\CategoryController::class,'show']);
});
Route::group(['prefix' => 'type'], function(){
    Route::get('', [App\Http\Controllers\TypeController::class,'index']);
    Route::get('{id}', [App\Http\Controllers\TypeController::class,'show']);
});

Route::apiResource('category', App\Http\Controllers\CategoryController::class,['as' => 'category'])->only(['store','update','destroy'])->middleware(['auth:api']);
Route::group(['prefix' => 'post'], function(){
    Route::get('', [App\Http\Controllers\PostController::class,'index']);
    Route::get('{id}', [App\Http\Controllers\PostController::class,'show']);
});
Route::apiResource('post', App\Http\Controllers\PostController::class,['as' => 'post'])->only(['store','update','destroy'])->middleware(['auth:api']);
Route::apiResource('type', App\Http\Controllers\TypeController::class,['as' => 'type'])->only(['store','update','destroy'])->middleware(['auth:api']);
Route::apiResource('position', App\Http\Controllers\PositionController::class,['as' => 'position'])->middleware(['auth:api']);;
Route::apiResource('status', App\Http\Controllers\StatusController::class,['as' => 'status'])->middleware(['auth:api']);
Route::group(['prefix' => 'wilayah'],function(){
    Route::get('province',[App\Http\Controllers\WilayahController::class,'province'])->name('wilayah.province');
    Route::get('regency/{id}',[App\Http\Controllers\WilayahController::class,'regency'])->name('wilayah.regency');
    Route::get('district/{id}',[App\Http\Controllers\WilayahController::class,'district'])->name('wilayah.district');
    Route::get('village/{id}',[App\Http\Controllers\WilayahController::class,'village'])->name('wilayah.village');
});
Route::group(['prefix' => 'graph'], function(){
    Route::get('province', [App\Http\Controllers\GraphController::class,'province']);
});