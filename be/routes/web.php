<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Artisan;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/
Route::get('/', function () {
    return view('welcome');
});
Route::get('/install', function () {
    Artisan::call('migrate:refresh');
    Artisan::call('db:seed');
    shell_exec('php ../artisan passport:install');
    // Artisan::call('passport:install');
    return "Backend for Covid Tracker Has Been Install.";
});