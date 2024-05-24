@extends('layouts.main')

@section('content')
<div class="container-xxl flex-grow-1 container-p-y">
  <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Master / </span> {{ $title }}</h4>

	@if(session('success'))
    <div class="alert alert-info">
      {{session('success')}}
    </div>
  @endif
  @if(session('danger'))
    <div class="alert alert-danger">
      {{session('danger')}}
    </div>
  @endif

  <div class="row">
    <!-- Basic -->
    <div class="col-md-12">
      <div class="card mb-4">
        <h5 class="card-header">{{ $title }}</h5>
        <div class="card-body demo-vertical-spacing demo-only-element">

          <form action="#" method="POST">
            <div class="form-password-toggle mb-3">
              <label for="name" class="form-label">Name</label>
              <div class="input-group">
                <span class="input-group-text" id="basic-addon11">#</span>
                <input
                  readonly
                  type="text"
                  name="name"
                  class="form-control @error('name') is-invalid @enderror"
                  placeholder="Name"
                  aria-label="Name"
                  aria-describedby="basic-addon11"
                  value="{{ $data->name }}"
                />
                @error('name')<div class="invalid-feedback ml-1">{{ $message }}</div>@enderror
              </div>
            </div>

            <div class="form-password-toggle mb-3">
              <label for="email" class="form-label">Email</label>
              <div class="input-group">
                <span class="input-group-text" id="basic-addon11">#</span>
                <input
                  readonly
                  type="text"
                  name="email"
                  class="form-control @error('email') is-invalid @enderror"
                  placeholder="Email"
                  aria-label="Email"
                  aria-describedby="basic-addon11"
                  value="{{ $data->email }}"
                />
                @error('email')<div class="invalid-feedback ml-1">{{ $message }}</div>@enderror
              </div>
            </div>

            <div class="form-password-toggle mb-3">
              <label for="role_id" class="form-label">Access</label>
              <div class="input-group">
                <span class="input-group-text" id="basic-addon11">#</span>
                <input
                  readonly
                  type="text"
                  name="role_id"
                  class="form-control @error('role_id') is-invalid @enderror"
                  placeholder="role_id"
                  aria-label="role_id"
                  aria-describedby="basic-addon11"
                  value="{{ $data->role->role }}"
                />
                @error('role_id')<div class="invalid-feedback ml-1">{{ $message }}</div>@enderror
              </div>
            </div>

            {{-- <button type="submit" class="btn btn-primary">Submit</button> --}}
          </form>

        </div>
      </div>
    </div>
  </div>
</div>
@endsection
