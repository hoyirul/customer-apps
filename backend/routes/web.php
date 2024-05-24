<?php

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Web\HomeController as WebHomeController;
use App\Http\Controllers\Web\RoleController as WebRoleController;
use App\Http\Controllers\Web\UserController as WebUserController;
use App\Http\Controllers\Web\SettingController as WebSettingController;
use App\Http\Controllers\Web\CustomerController as WebCustomerController;

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

use Illuminate\Support\Facades\Artisan;

Route::get('/storage', function () {
    Artisan::call('storage:link');
    return 'Storage link created successfully.';
});

use Carbon\Carbon;
Route::get('/timezone', function () {
    return Carbon::now()->format('d-m-Y H:i:s');
});

Route::get('/', function () {
    return redirect('/login');
});

Auth::routes([
    'register' => false,
    'reset' => false,
    'verify' => false,
]);

// Route::get('/home', [App\Http\Controllers\HomeController::class, 'index'])->name('home');
Route::middleware(['auth'])->group(function () {
    Route::prefix('v1')->group(function () {
        Route::get('/home', [WebHomeController::class, 'index']);
        Route::resource('roles', WebRoleController::class);
        Route::resource('customers', WebCustomerController::class);

        // Users
        Route::get('users/{status}/{role_id}', [WebUserController::class, 'index']);
        Route::get('users/{status}', [WebUserController::class, 'banned']);
        Route::get('users/{status}/{role_id}/{id}', [WebUserController::class, 'update_status']);
        Route::controller(WebUserController::class)->group(function(){
            Route::post('users', [WebUserController::class, 'store']);
            Route::get('{id}/users', [WebUserController::class, 'create']);
            Route::get('{id}/users/edit', [WebUserController::class, 'edit']);
            Route::put('users/{id}', [WebUserController::class, 'update']);
        });

        // setting and accounts
        Route::get('accounts', [WebSettingController::class, 'account']);
        Route::get('settings', [WebSettingController::class, 'setting']);
        Route::put('settings/update_password', [WebSettingController::class, 'update_password']);
        Route::put('settings/update_profile', [WebSettingController::class, 'update_profile']);
    });
});
