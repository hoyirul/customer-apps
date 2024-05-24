<?php

use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\RoleController;
use App\Http\Controllers\Api\UserController;
use App\Http\Controllers\Api\CustomerController;
use App\Http\Controllers\Api\SettingController;
use Illuminate\Http\Request;
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

Route::prefix('/auth')->group(function(){
    Route::post('/login', [AuthController::class, 'login']);
    Route::post('/register', [AuthController::class, 'register']);
});

Route::middleware('auth:sanctum')->group(function(){
    Route::prefix('/auth')->group(function(){
        Route::post('/logout', [AuthController::class, 'logout']);
    });

    Route::prefix('/settings')->group(function(){
        Route::get('/profile', [SettingController::class, 'profile']);
        Route::put('/profile', [SettingController::class, 'updateProfile']);
        Route::put('/change-password', [SettingController::class, 'updatePassword']);
    });

    Route::apiResource('/users', UserController::class);
    Route::apiResource('/roles', RoleController::class);
    Route::apiResource('/customers', CustomerController::class);
    Route::get('/cities', [CustomerController::class, 'getCities']);
});
