@extends('layouts.main')

@section('content')
<div class="container-xxl flex-grow-1 container-p-y">
  <a class="btn btn-primary me-1 float-end" href="/v1/customers/create"
    ><i class="bx bx-plus me-1"></i> Add Data</a
  >
  <h4 class="fw-bold @if(!session('success') || !session('danger')) py-3 mb-4 @endif"><span class="text-muted fw-light">Master /</span> {{ $title }}</h4>

  <div class="card">
    <h5 class="card-header">{{ $title }}</h5>
    <div class="table-responsive text-nowrap container mb-4">
      <table id="table" class="table">
        <thead>
          <tr>
            <th class="text-center">No</th>
            <th>Outlet Name</th>
            <th>Outlet Owner</th>
            <th>Phone</th>
            <th>Address</th>
            <th>Postal Code</th>
            <th>City</th>
            <th>Lat/Long</th>
            <th>Photo</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody class="table-border-bottom-0">
          @foreach ($data as $item)
            <tr>
              <td class="text-center">{{ $loop->iteration }}</td>
              <td><i class="fab fa-angular fa-lg text-danger"></i> <strong>{{ Str::upper($item->outlet_name) }}</strong></td>
              <td>{{ $item->user->name }}</td>
              <td>{{ $item->phone }}</td>
              <td>{{ $item->address }}</td>
              <td>{{ $item->postal_code }}</td>
              <td>{{ $item->city }}</td>
              <td>{{ $item->latitude }}, {{ $item->longitude }}</td>
              <td>
                <a href="{{ asset('storage/'.$item->photo) }}" target="_blank">
                  <img src="{{ asset('storage/'.$item->photo) }}" alt="{{ $item->outlet_name }}" width="50" height="50">
                </a>
              </td>
              <td>
                <form action="/v1/customers/{{ $item->id }}" onsubmit="return confirm('Are you sure?')" method="post">
                  @csrf
                  @method('DELETE')
                  <a class="badge bg-label-info me-1" href="/v1/customers/{{ $item->id }}/edit"><i class="bx bx-edit-alt me-1"></i> Edit</a>
                  <button type="submit" class="badge bg-label-danger me-1 border-0">
                    <i class="bx bx-trash me-1"></i>
                  Delete
                  </button>
                </form>
              </td>
            </tr>
          @endforeach
        </tbody>
      </table>
    </div>
  </div>
  <!--/ Basic Bootstrap Table -->

</div>
@endsection
