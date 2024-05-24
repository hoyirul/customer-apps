@extends('layouts.main')

@section('content')
<div class="container-xxl flex-grow-1 container-p-y">
  <a class="btn btn-primary me-1 float-end" href="/v1/customers"
    ><i class="bx bx-arrow-back me-1"></i> Back to {{ $title }}</a
  >
  <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Master / {{ $title }} /</span> Add</h4>

  <!-- Basic Bootstrap Table -->
  @include('partials.alert')

  <div class="row">
    <!-- Basic -->
    <div class="col-md-12">
      <div class="card mb-4">
        <h5 class="card-header">{{ $title }}</h5>
        <div class="card-body demo-vertical-spacing demo-only-element">

          <form action="/v1/customers" method="POST" enctype="multipart/form-data">
            @csrf
            <div class="form-password-toggle mb-3 row">
              <div class="col-md-6">
                <label for="user_id" class="form-label">Outlet Owner</label>
                <select name="user_id" id="user_id"
                  class="form-control @error('user_id') is-invalid @enderror"
                  placeholder="Outlet Owner"
                  aria-label="Outlet Owner">
                    @foreach ($users as $outlet_owner)
                      <option value="{{ $outlet_owner->id }}" {{ (old('outlet_owner') == $outlet_owner->id) ? 'selected' : '' }}>{{ $outlet_owner->name }}</option>
                    @endforeach
                  </select>
                  @error('user_id')<div class="invalid-feedback ml-1">{{ $message }}</div>@enderror
              </div>
              <div class="col-md-6">
                <label for="outlet_name" class="form-label">Outlet Name</label>
                <div class="input-group">
                  <span class="input-group-text" id="basic-addon11">#</span>
                  <input
                      type="text"
                      name="outlet_name"
                      class="form-control @error('outlet_name') is-invalid @enderror"
                      placeholder="Outlet Name"
                      aria-label="Outlet Name"
                      aria-describedby="basic-addon11"
                      value="{{ old('outlet_name') }}"
                  />
                  @error('outlet_name')<div class="invalid-feedback ml-1">{{ $message }}</div>@enderror
                </div>
              </div>
            </div>

            <div class="form-password-toggle mb-3 row">
              <div class="col-md-6">
                <label for="address" class="form-label">Address</label>
                <div class="input-group">
                  <span class="input-group-text" id="basic-addon11">#</span>
                  <input
                      type="text"
                      name="address"
                      class="form-control @error('address') is-invalid @enderror"
                      placeholder="Address"
                      aria-label="Address"
                      aria-describedby="basic-addon11"
                      value="{{ old('address') }}"
                  />
                  @error('address')<div class="invalid-feedback ml-1">{{ $message }}</div>@enderror
                </div>
              </div>
              <div class="col-md-6">
                <label for="phone" class="form-label">Phone</label>
                <div class="input-group">
                  <span class="input-group-text" id="basic-addon11">#</span>
                  <input
                      type="text"
                      name="phone"
                      class="form-control @error('phone') is-invalid @enderror"
                      placeholder="Phone"
                      aria-label="Phone"
                      aria-describedby="basic-addon11"
                      value="{{ old('phone') }}"
                  />
                  @error('phone')<div class="invalid-feedback ml-1">{{ $message }}</div>@enderror
                </div>
              </div>
            </div>


            <div class="form-password-toggle mb-3 row">
              <div class="col-md-6">
                <label for="city" class="form-label">City</label>
                <div class="input-group">
                  <span class="input-group-text" id="basic-addon11">#</span>
                  <select id="city" name="city" class="form-control">
                    @if($cities && isset($cities['value']))
                      @foreach($cities['value'] as $city)
                        <option value="{{ $city['id'] }}" {{ (old('city') == $city['id']) ? 'selected' : '' }}>{{ $city['name'] }}</option>
                      @endforeach
                    @else
                      <option value="">Tidak ada data kota tersedia</option>
                    @endif
                  </select>
                  @error('city')<div class="invalid-feedback ml-1">{{ $message }}</div>@enderror
                </div>
              </div>

              <div class="col-md-6">
                <label for="postal_code" class="form-label">Postal Code</label>
                <div class="input-group">
                  <span class="input-group-text" id="basic-addon11">#</span>
                  <input
                      type="text"
                      name="postal_code"
                      class="form-control @error('postal_code') is-invalid @enderror"
                      placeholder="Postal Code"
                      aria-label="Postal Code"
                      aria-describedby="basic-addon11"
                      value="{{ old('postal_code') }}"
                  />
                  @error('postal_code')<div class="invalid-feedback ml-1">{{ $message }}</div>@enderror
                </div>
              </div>
            </div>

            {{-- latitude dan longitude dengan hidden --}}
            <input type="hidden" name="latitude" id="latitude" value="{{ old('latitude') }}">
            <input type="hidden" name="longitude" id="longitude" value="{{ old('longitude') }}">

            <div class="form-password-toggle mb-3">
              <label for="photo" class="form-label">Photo | <span class="text-danger">Max: 1 MB</span></label>
              <div class="input-group">
                <span class="input-group-text" id="basic-addon11">#</span>
                <input
                  type="file"
                  name="photo"
                  id="photo"
                  class="form-control @error('photo') is-invalid @enderror"
                  placeholder="Photo"
                  aria-label="Photo"
                  aria-describedby="basic-addon11"
                  value="{{ old('photo') }}"
                />
                @error('photo')<div class="invalid-feedback ml-1">{{ $message }}</div>@enderror
              </div>
            </div>

            <button type="submit" class="btn btn-primary">Submit</button>
          </form>

        </div>
      </div>
    </div>
  </div>
</div>
@endsection
