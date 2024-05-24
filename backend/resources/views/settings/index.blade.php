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
    <div class="col-md-6">
      <div class="card mb-4">
        <h5 class="card-header">{{ $title }} Company</h5>
        <div class="card-body demo-vertical-spacing demo-only-element">

          <form action="/v1/settings/update_profile" method="POST" enctype="multipart/form-data">
            @csrf
            @method('PUT')

            <div class="form-password-toggle mb-3">
              <label for="email" class="form-label">My Email</label>
              <div class="input-group">
                <span class="input-group-text" id="basic-addon11">#</span>
                <input
                  type="text"
                  name="email"
                  class="form-control @error('email') is-invalid @enderror"
                  placeholder="My Email"
                  aria-label="My Email"
                  aria-describedby="basic-addon11"
                  value="{{ $data->email }}"
                />
                @error('email')<div class="invalid-feedback ml-1">{{ $message }}</div>@enderror
              </div>
            </div>

            <div class="form-password-toggle mb-3">
              <label for="name" class="form-label">My Name</label>
              <div class="input-group">
                <span class="input-group-text" id="basic-addon11">#</span>
                <input
                  type="text"
                  name="name"
                  class="form-control @error('name') is-invalid @enderror"
                  placeholder="My Name"
                  aria-label="My Name"
                  aria-describedby="basic-addon11"
                  value="{{ $data->name }}"
                />
                @error('name')<div class="invalid-feedback ml-1">{{ $message }}</div>@enderror
              </div>
            </div>

            <button type="submit" class="btn btn-primary">Update Profile</button>
          </form>

        </div>
      </div>
    </div>

    <!-- Basic -->
    <div class="col-md-6">
      <div class="card mb-4">
        <h5 class="card-header">{{ $title }} Password</h5>
        <div class="card-body demo-vertical-spacing demo-only-element">

          <form action="/v1/settings/update_password" method="POST">
            @csrf
            @method('PUT')
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
              <label for="password" class="form-label">New Password</label>
              <div class="input-group">
                <span class="input-group-text" id="basic-addon11">#</span>
                <input
                  type="password"
                  name="password"
                  class="form-control @error('password') is-invalid @enderror"
                  placeholder="New Password"
                  aria-label="New Password"
                  aria-describedby="basic-addon11"
                />
                @error('password')<div class="invalid-feedback ml-1">{{ $message }}</div>@enderror
              </div>
            </div>

            <div class="form-password-toggle mb-3">
              <label for="password_confirmation" class="form-label">Password Confirmation</label>
              <div class="input-group">
                <span class="input-group-text" id="basic-addon11">#</span>
                <input
                  type="password"
                  name="password_confirmation"
                  class="form-control @error('password_confirmation') is-invalid @enderror"
                  placeholder="Password Confirmation"
                  aria-label="Password Confirmation"
                  aria-describedby="basic-addon11"
                />
                @error('password_confirmation')<div class="invalid-feedback ml-1">{{ $message }}</div>@enderror
              </div>
            </div>

            <button type="submit" class="btn btn-primary">Update Password</button>
          </form>

        </div>
      </div>
    </div>

  </div>
</div>
@endsection
