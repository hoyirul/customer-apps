<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\LoginRequest;
use App\Http\Requests\RegisterRequest;
use App\Models\User;
use App\Traits\ApiResponse;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Http\Exceptions\HttpResponseException;

class AuthController extends Controller
{
    use ApiResponse;

    public function login(LoginRequest $request){
        try{
            $credentials = request(['email', 'password']);
            if(!Auth::attempt($credentials)){
                return $this->apiError(
                    'Credentials not match',
                    Response::HTTP_NOT_FOUND
                );
            }

            $user = User::where('email', $credentials['email'])
                        ->where('role_id', 2)
                        ->first();
            if(!$user){
                return $this->apiError(
                    'Unauthorized',
                    Response::HTTP_UNAUTHORIZED
                );
            }

            if(!Hash::check($request->password, $user->password, [])){
                throw new \Exception('Error in Login');
            }
            $tokenResult = $user->createToken('authToken')->plainTextToken;
            return $this->apiSuccess([
                'access_token' => $tokenResult,
                'token_type' => 'Bearer',
                'user' => $user
            ]);
        } catch(\Throwable $e){
            throw new HttpResponseException($this->apiError(
                $e->getMessage(),
                Response::HTTP_UNAUTHORIZED
            ));
        }
    }

    public function register(RegisterRequest $request){
        try{
            $checkUser = User::where('email', $request->email)->first();
            if($checkUser){
                return $this->apiError(
                    'Email '.$request->email.' is already in use!',
                    Response::HTTP_UNPROCESSABLE_ENTITY
                );
            }
            $user = User::create([
                'name' => $request->name,
                'email' => $request->email,
                'password' => Hash::make($request->password),
                'role_id' => 2
            ]);
            $tokenResult = $user->createToken('authToken')->plainTextToken;
            return $this->apiSuccess([
                'access_token' => $tokenResult,
                'token_type' => 'Bearer',
                'user' => $user
            ]);
        } catch(\Throwable $e){
            throw new HttpResponseException($this->apiError(
                $e->getMessage(),
                Response::HTTP_UNAUTHORIZED
            ));
        }
    }

    public function logout(){
        try{
            auth()->user()->tokens()->delete();
            return $this->apiSuccess('Tokens Revoked');
        } catch(\Throwable $e){
            throw new HttpResponseException($this->apiError(
                null,
                Response::HTTP_INTERNAL_SERVER_ERROR
            ));
        }
    }
}
