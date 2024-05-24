@extends('layouts.main')

@section('content')
<div class="container-xxl flex-grow-1 container-p-y">
  <a class="btn btn-primary me-1 float-end" href="/v1/roles"
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

          <form action="/v1/roles" method="POST" enctype="multipart/form-data">
            @csrf
            <div class="form-password-toggle mb-3">
              <label for="slide_number" class="form-label">Number of Slide</label>
              <div class="input-group">
                <span class="input-group-text" id="basic-addon11">#</span>
                <input
                  type="number"
                  name="slide_number"
                  class="form-control @error('slide_number') is-invalid @enderror"
                  placeholder="Number of Slide"
                  aria-label="Number of Slide"
                  aria-describedby="basic-addon11"
                  value="{{ old('slide_number') }}"
                />
                @error('slide_number')<div class="invalid-feedback ml-1">{{ $message }}</div>@enderror
              </div>
            </div>

            <div class="form-password-toggle mb-3">
              <label for="menu" class="form-label">Select Menu</label>
              <div class="input-group">
                <span class="input-group-text" id="basic-addon11">#</span>
                <select name="menu" id="menu"
                  class="form-control @error('menu') is-invalid @enderror"
                  placeholder="Number of menu"
                  aria-label="Number of menu">
                    <option value="beranda" {{ (old('menu') == 'beranda') ? 'selected' : '' }}>Beranda</option>
                    <option value="produk" {{ (old('menu') == 'produk') ? 'selected' : '' }}>Produk</option>
                    <option value="layanan" {{ (old('menu') == 'layanan') ? 'selected' : '' }}>Layanan</option>
                    <option value="tentang" {{ (old('menu') == 'tentang') ? 'selected' : '' }}>Tentang</option>
                    <option value="kontak" {{ (old('menu') == 'kontak') ? 'selected' : '' }}>Kontak</option>
                    <option value="testimoni" {{ (old('menu') == 'testimoni') ? 'selected' : '' }}>Testimoni</option>
                </select>
                @error('menu')<div class="invalid-feedback ml-1">{{ $message }}</div>@enderror
              </div>
            </div>

            <div class="form-password-toggle mb-3">
              <label for="slide" class="form-label">Is Slide Show ?</label>
              <div class="input-group">
                <span class="input-group-text" id="basic-addon11">#</span>
                <select name="slide" id="slide"
                  class="form-control @error('slide') is-invalid @enderror"
                  placeholder="Number of Slide"
                  aria-label="Number of Slide">
                    <option value="1" {{ (old('slide') == 1) ? 'selected' : '' }}>Yes</option>
                    <option value="0" {{ (old('slide') == 0) ? 'selected' : '' }}>No</option>
                </select>
                @error('slide')<div class="invalid-feedback ml-1">{{ $message }}</div>@enderror
              </div>
            </div>

            <div class="form-password-toggle mb-3">
              <label for="image" class="form-label">File of Slide | <span class="text-danger">Max: 1 MB</span></label>
              <div class="input-group">
                <span class="input-group-text" id="basic-addon11">#</span>
                <input
                  type="file"
                  name="image"
                  id="image"
                  class="form-control @error('image') is-invalid @enderror"
                  placeholder="File of Slide"
                  aria-label="File of Slide"
                  aria-describedby="basic-addon11"
                  value="{{ old('image') }}"
                />
                @error('image')<div class="invalid-feedback ml-1">{{ $message }}</div>@enderror
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
