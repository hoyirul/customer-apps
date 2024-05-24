@extends('layouts.auth')

@section('content')
<div class="authentication-wrapper authentication-basic container-p-y">
  <div class="authentication-inner">
    <!-- Register -->
    <div class="card">
      <div class="card-body">
        <!-- /Logo -->
        <h4 class="mb-2">Welcome to Administrator! 👋</h4>
        <p class="mb-4">Please sign-in to your account and start the adventure</p>

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

        <form method="POST" action="{{ route('login') }}">
          @csrf

          <div id="formAuthentication" class="mb-3">
            <div class="mb-3">
              <label for="email" class="form-label">Email</label>
              <input
                type="email"
                class="form-control @error('email') is-invalid @enderror" name="email" value="{{ old('email') }}"
                id="email"
                name="email"
                placeholder="Enter your email"
                autofocus
              />
              @error('email')
                <span class="invalid-feedback" role="alert">
                  <strong>{{ $message }}</strong>
                </span>
              @enderror
            </div>
            <div class="mb-3 form-password-toggle">
              <div class="input-group input-group-merge">
                <input
                  type="password"
                  id="password"
                  class="form-control @error('password') is-invalid @enderror"
                  name="password"
                  placeholder="&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;"
                  aria-describedby="password"
                />
                <span class="input-group-text cursor-pointer"><i class="bx bx-hide"></i></span>
                @error('password')
                  <span class="invalid-feedback" role="alert">
                    <strong>{{ $message }}</strong>
                  </span>
                @enderror
              </div>
            </div>
            <div class="mb-3">
              <div class="form-check">
                <input class="form-check-input" type="checkbox" id="remember-me" />
                <label class="form-check-label" for="remember-me"> Remember Me </label>
              </div>
            </div>
            <div class="mb-3">
              <button class="btn btn-primary d-grid w-100" type="submit">Sign in</button>
            </div>
          </div>
        </form>
      </div>
    </div>
    <!-- /Register -->
  </div>
</div>
@endsection
