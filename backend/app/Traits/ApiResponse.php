<?php

namespace App\Traits;

trait ApiResponse
{
    protected function apiSuccess($data, $code = 200, $message = null){
        return response()->json([
            'message' => $message,
            'data' => $data
        ], $code);
    }

    protected function apiError($message, $code){
        return response()->json([
            'message' => $message
        ], $code);
    }
}
