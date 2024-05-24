<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class HomeController extends Controller
{
    public function index()
    {
        $title = 'Dashboard';
        $data = [
            'user' => 'Administrator',
            'role' => 'Administrator'
        ];
        return view('home.index', compact('title', 'data'));
    }
}
