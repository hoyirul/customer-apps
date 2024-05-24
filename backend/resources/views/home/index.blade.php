@extends('layouts.main')

@section('content')
  <div class="container-xxl flex-grow-1 container-p-y">
    <div class="row">
      <div class="col-lg-12 mb-4 order-0">
        <div class="card">
          <div class="d-flex align-items-end row">
            <div class="col-sm-7">
              <div class="card-body">
                <h5 class="card-title text-primary">Congratulations {{ Auth::user()->name }}! 🎉</h5>
                <p class="mb-4">
                  Dashboard - CustomerApps 2023 | Termukan berbagai kesenian dan kerajinan Hanya di CustomerApps
                </p>
              </div>
            </div>
            <div class="col-sm-5 text-center text-sm-left">
              <div class="card-body pb-0 px-0 px-md-4">
                <img
                  src="{{ asset('assets/img/illustrations/man-with-laptop-light.png') }}"
                  height="140"
                  alt="View Badge User"
                  data-app-dark-img="illustrations/man-with-laptop-dark.png"
                  data-app-light-img="illustrations/man-with-laptop-light.png"
                  />
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="col-lg-6 col-md-6 order-1">
        <div class="row">
          <div class="col-lg-6 col-md-12 col-6 mb-4">
            <div class="card">
              <div class="card-body">
                <div class="card-title d-flex align-items-start justify-content-between">
                  <div class="avatar flex-shrink-0">
                    <img
                      src="{{ asset('assets/img/icons/unicons/chart-success.png') }}"
                      alt="chart success"
                      class="rounded"
                      />
                  </div>
                </div>
                <span class="fw-semibold d-block mb-1">Total Users</span>
                {{-- <h4 class="card-title mb-2">{{ $data['approved'] }} Approved Users</h4> --}}
              </div>
            </div>
          </div>
          <div class="col-lg-6 col-md-12 col-6 mb-4">
            <div class="card">
              <div class="card-body">
                <div class="card-title d-flex align-items-start justify-content-between">
                  <div class="avatar flex-shrink-0">
                    <img
                      src="{{ asset('assets/img/icons/unicons/wallet-info.png') }}"
                      alt="Credit Card"
                      class="rounded"
                      />
                  </div>
                </div>
                <span class="fw-semibold d-block mb-1">Total Users</span>
                {{-- <h4 class="card-title mb-2">{{ $data['pending'] }} Pending Users</h4> --}}
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="col-12 col-md-12 col-lg-6 order-3 order-md-2">
        <div class="row">
          <div class="col-6 mb-4">
            <div class="card">
              <div class="card-body">
                <div class="card-title d-flex align-items-start justify-content-between">
                  <div class="avatar flex-shrink-0">
                    <img src="{{ asset('assets/img/icons/unicons/paypal.png') }}" alt="Credit Card" class="rounded" />
                  </div>
                </div>
                <span class="d-block mb-1">Total Transactions</span>
                {{-- <h4 class="card-title text-nowrap mb-2">{{ $data['transaction'] }} Transactions</h4> --}}
              </div>
            </div>
          </div>
          <div class="col-6 mb-4">
            <div class="card">
              <div class="card-body">
                <div class="card-title d-flex align-items-start justify-content-between">
                  <div class="avatar flex-shrink-0">
                    <img src="{{ asset('assets/img/icons/unicons/cc-primary.png') }}" alt="Credit Card" class="rounded" />
                  </div>
                </div>
                <span class="fw-semibold d-block mb-1">Total Categories</span>
                {{-- <h4 class="card-title mb-2">{{ $data['waste_category'] }} Categories</h4> --}}
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
@endsection
