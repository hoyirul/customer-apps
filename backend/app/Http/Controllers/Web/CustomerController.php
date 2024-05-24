<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\Customer;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Storage;

class CustomerController extends Controller
{
    public function index()
    {
        $title = 'Customers Table';
        $data = Customer::with('user')->orderBy('id', 'desc')->get();
        return view('customers.index', compact('data', 'title'));
    }

    public function create()
    {
        $title = 'Customers Table';
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

        $users = User::orderBy('id', 'desc')->where('id', '!=', 1)->get();
        return view('customers.create', compact('title', 'users', 'cities'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'user_id' => 'required|integer',
            'outlet_name' => 'required|string',
            'phone' => 'required|string',
            'address' => 'required|string',
            'city' => 'required|string',
            'postal_code' => 'required|string',
            'photo' => 'nullable|image',
            'latitude' => 'nullable|string',
            'longitude' => 'nullable|string',
            'photo' => 'nullable|image|mimes:jpg,jpeg,png|max:2048'
        ]);

        if ($request->hasFile('photo')) {
            $photo_name = $request->file('photo')->store('customers', 'public');
        } else {
            $photo_name = null;
        }

        Customer::create([
            'user_id' => $request->user_id,
            'outlet_name' => $request->outlet_name,
            'phone' => $request->phone,
            'address' => $request->address,
            'city' => $request->city,
            'postal_code' => $request->postal_code,
            'photo' => $request->photo,
            'latitude' => $request->latitude,
            'longitude' => $request->longitude,
            'photo' => $photo_name
        ]);

        return redirect('/v1/customers')->with('success', "Data added successfully!");
    }

    public function show($id)
    {
        $title = 'Customers Table';
        $data = Customer::with('user')->where('id', $id)->first();
        $users = User::orderBy('id', 'desc')->where('id', '!=', 1)->get();
        return view('customers.show', compact('data', 'title'));
    }

    public function edit($id)
    {
        $title = 'Customers Table';
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

        $data = Customer::with('user')->where('id', $id)->first();
        $users = User::orderBy('id', 'desc')->where('id', '!=', 1)->get();
        return view('customers.edit', compact('data', 'title', 'users', 'cities'));
    }

    public function update(Request $request, $id)
    {
        $request->validate([
            'user_id' => 'required|integer',
            'outlet_name' => 'required|string',
            'phone' => 'required|string',
            'address' => 'required|string',
            'city' => 'required|string',
            'postal_code' => 'required|string',
            'photo' => 'nullable|image',
            'latitude' => 'nullable|string',
            'longitude' => 'nullable|string',
            'photo' => 'nullable|image|mimes:jpg,jpeg,png|max:2048'
        ]);

        $data = Customer::where('id', $id)->first();

        if ($request->hasFile('photo')) {
            if ($data->photo) {
                Storage::disk('public')->delete($data->photo);
            }
            $photo_name = $request->file('photo')->store('customers', 'public');
        } else {
            $photo_name = $data->photo;
        }

        Customer::where('id', $id)->update([
            'user_id' => $request->user_id,
            'outlet_name' => $request->outlet_name,
            'phone' => $request->phone,
            'address' => $request->address,
            'city' => $request->city,
            'postal_code' => $request->postal_code,
            'photo' => $request->photo,
            'latitude' => $request->latitude,
            'longitude' => $request->longitude,
            'photo' => $photo_name
        ]);

        return redirect('/v1/customers')->with('success', "Data updated successfully!");
    }

    public function destroy($id)
    {
        $data = Customer::where('id', $id)->first();
        if ($data->photo) {
            Storage::disk('public')->delete($data->photo);
        }
        Customer::where('id', $id)->delete();
        return redirect('/v1/customers')->with('success', "Data deleted successfully!");
    }
}
