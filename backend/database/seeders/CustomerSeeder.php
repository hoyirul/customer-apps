<?php

namespace Database\Seeders;

use App\Models\Customer;
use Illuminate\Database\Seeder;

class CustomerSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $data = [
            [
                'user_id' => 2,
                'outlet_name' => 'Outlet 1',
                'phone' => '081234567890',
                'address' => 'Jl. Raya No. 1',
                'city' => '35.01',
                'postal_code' => '12345',
                'photo' => 'customer1.jpg',
                'latitude' => '-6.123456',
                'longitude' => '106.123456'
            ],
            [
                'user_id' => 3,
                'outlet_name' => 'Outlet 2',
                'phone' => '081234567891',
                'address' => 'Jl. Raya No. 2',
                'city' => '35.02',
                'postal_code' => '12346',
                'photo' => 'customer2.jpg',
                'latitude' => '-6.123457',
                'longitude' => '106.123457'
            ],
        ];

        foreach($data as $row){
            Customer::create([
                'user_id' => $row['user_id'],
                'outlet_name' => $row['outlet_name'],
                'phone' => $row['phone'],
                'address' => $row['address'],
                'city' => $row['city'],
                'postal_code' => $row['postal_code'],
                'photo' => $row['photo'],
                'latitude' => $row['latitude'],
                'longitude' => $row['longitude']
            ]);
        }
    }
}
