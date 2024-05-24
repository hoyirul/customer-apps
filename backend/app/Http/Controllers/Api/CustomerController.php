<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\CustomerRequest;
use App\Models\Customer;
use App\Traits\ApiResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Http;

class CustomerController extends Controller
{
    use ApiResponse;

    public function getCities()
    {
        try {
            $api_key = env('BINDERBYTE_API_KEY');
            $id_provinsi = 35; // Jawa Timur
            $response = Http::get('https://api.binderbyte.com/wilayah/kabupaten', [
                'api_key' => $api_key,
                'id_provinsi' => $id_provinsi
            ]);

            if ($response->successful()) {
                $cities = $response->json();
            } else {
                $cities = null;
            }

            return $this->apiSuccess($cities['value'], Response::HTTP_OK);
        } catch (\Throwable $e) {
            return $this->apiError(
                $e->getMessage(),
                Response::HTTP_INTERNAL_SERVER_ERROR
            );
        }
    }

    public function index()
    {
        try {
            $response = Customer::where('user_id', auth()->user()->id)->get();
            return $this->apiSuccess($response, Response::HTTP_OK);
        } catch (\Throwable $e) {
            return $this->apiError(
                $e->getMessage(),
                Response::HTTP_INTERNAL_SERVER_ERROR
            );
        }
    }

    public function store(CustomerRequest $request)
    {
        try {
            $validated = $request->validated();
            $response = Customer::create([
                'user_id' => auth()->user()->id,
                'outlet_name' => $validated['outlet_name'],
                'phone' => $validated['phone'],
                'address' => $validated['address'],
                'city' => $validated['city'],
                'postal_code' => $validated['postal_code'],
                'photo' => $request->file('photo')->store('photos', 'public'),
                'latitude' => $validated['latitude'],
                'longitude' => $validated['longitude']
            ]);
            return $this->apiSuccess($response, Response::HTTP_CREATED);
        } catch (\Throwable $e) {
            return $this->apiError(
                $e->getMessage(),
                Response::HTTP_INTERNAL_SERVER_ERROR
            );
        }
    }

    public function show($id)
    {
        try {
            $response = Customer::find($id);
            if ($response == null) {
                return $this->apiError(
                    'Data not found',
                    Response::HTTP_NOT_FOUND
                );
            }
            return $this->apiSuccess($response);
        } catch (\Throwable $e) {
            return $this->apiError(
                $e->getMessage(),
                Response::HTTP_INTERNAL_SERVER_ERROR
            );
        }
    }

    public function update(CustomerRequest $request, $id)
    {
        try {
            $validated = $request->validated();

            $response = Customer::find($id);
            if ($response == null) {
                return $this->apiError(
                    'Data not found',
                    Response::HTTP_NOT_FOUND
                );
            }

            $response->update([
                'outlet_name' => $validated['outlet_name'],
                'phone' => $validated['phone'],
                'address' => $validated['address'],
                'city' => $validated['city'],
                'postal_code' => $validated['postal_code'],
                'photo' => $request->file('photo')->store('photos', 'public'),
                'latitude' => $validated['latitude'],
                'longitude' => $validated['longitude']
            ]);
            return $this->apiSuccess($response, Response::HTTP_OK);
        } catch (\Throwable $e) {
            return $this->apiError(
                $e->getMessage(),
                Response::HTTP_INTERNAL_SERVER_ERROR
            );
        }
    }

    public function destroy($id)
    {
        try {
            $response = Customer::find($id);
            if ($response == null) {
                return $this->apiError(
                    'Data not found',
                    Response::HTTP_NOT_FOUND
                );
            }
            $response->delete();
            return $this->apiSuccess($response, Response::HTTP_OK);
        } catch (\Throwable $e) {
            return $this->apiError(
                $e->getMessage(),
                Response::HTTP_INTERNAL_SERVER_ERROR
            );
        }
    }
}
