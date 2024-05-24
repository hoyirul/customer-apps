@extends('layouts.main')

@section('content')
<div class="container-xxl flex-grow-1 container-p-y">
  {{-- <a class="btn btn-primary me-1 float-end" href="/v1/roles/create"
    ><i class="bx bx-plus me-1"></i> Add Data</a
  > --}}
  <h4 class="fw-bold @if(!session('success') || !session('danger')) py-3 mb-4 @endif"><span class="text-muted fw-light">Master /</span> {{ $title }}</h4>

  <div class="card">
    <h5 class="card-header">{{ $title }}</h5>
    <div class="table-responsive text-nowrap container mb-4">
      <table id="table" class="table">
        <thead>
          <tr>
            <th class="text-center">No</th>
            <th>Role</th>
            <th>Updated At</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody class="table-border-bottom-0">
          @foreach ($data as $item)
            <tr>
              <td class="text-center">{{ $loop->iteration }}</td>
              <td><i class="fab fa-angular fa-lg text-danger"></i> <strong>{{ Str::upper($item->role) }}</strong></td>
              <td>{{ $item->updated_at }}</td>
              <td>
                <a class="badge bg-label-info me-1" href="/v1/roles/{{ $item->id }}/edit"><i class="bx bx-edit-alt me-1"></i> Edit</a>
                {{-- <form action="/v1/roles/{{ $item->id }}" onsubmit="return confirm('Are you sure?')" method="post">
                  @csrf
                  @method('DELETE')
                  <button type="submit" class="badge bg-label-danger me-1 border-0">
                    <i class="bx bx-trash me-1"></i>
                  Delete
                  </button>
                </form> --}}
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
