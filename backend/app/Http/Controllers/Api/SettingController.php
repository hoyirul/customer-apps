<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\ChangePasswordRequest;
use App\Models\User;
use App\Traits\ApiResponse;
use Illuminate\Support\Facades\Hash;

class SettingController extends Controller
{
    use ApiResponse;

    public function profile()
    {
        $user = auth()->user();

        return $this->apiSuccess('Profile successfully retrieved!', $user);
    }

    public function updateProfile()
    {
        $id = auth()->user()->id;

        $user = User::where('id', $id)->first();

        $user->update(request()->all());

        return $this->apiSuccess('Profile successfully updated!', $user);
    }

    public function updatePassword(ChangePasswordRequest $request)
    {
        $validated = $request->validated();
        $id = auth()->user()->id;

        $check = User::where('id', $id)->first();

        if (!(Hash::check($validated['old_password'], $check->password))) {
            return response()->json([
                'success'   => false,
                'message'   => 'Validation errors',
                'data'      => [
                    'old_password' => ['The old password is incorrect.']
                ]
            ], 422);
        }

        User::where('id', $id)->update([
            'password' => Hash::make($validated['password']),
        ]);

        return $this->apiSuccess('Password successfully updated!');
    }
}
