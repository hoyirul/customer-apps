<aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme">
  <div class="app-brand demo">
    <a href="/" class="app-brand-link">
      {{-- <img src="{{ asset('member/img/logo/dark-logo.png') }}" class="w-100 p-3" alt=""> --}}
      <b>CustomerApps</b>
    </a>
    <a href="/" class="layout-menu-toggle menu-link text-large ms-auto d-block d-xl-none">
    <i class="bx bx-chevron-left bx-sm align-middle"></i>
    </a>
  </div>
  <div class="menu-inner-shadow"></div>
  <ul class="menu-inner py-1">
    <!-- Dashboard -->
    <li class="menu-item {{ ($title == 'Dashboard') ? 'active' : '' }}">
      <a href="/v1/home" class="menu-link">
        <i class="menu-icon tf-icons bx bx-home-circle"></i>
        <div data-i18n="Analytics">Dashboard</div>
      </a>
    </li>
    <!-- Layouts -->
    <li class="menu-header small text-uppercase">
      <span class="menu-header-text">Master</span>
    </li>

    <li class="menu-item {{ ($title == 'Roles Table') ? 'active' : '' }}">
      <a href="/v1/roles" class="menu-link">
        <i class="menu-icon tf-icons bx bx-file"></i>
        <div data-i18n="Analytics">Roles</div>
      </a>
    </li>

    <li class="menu-item {{ ($title == 'Customers Table') ? 'active' : '' }}">
      <a href="/v1/customers" class="menu-link">
        <i class="menu-icon tf-icons bx bx-group"></i>
        <div data-i18n="Analytics">Customers</div>
      </a>
    </li>

    <!-- Misc -->
    <li class="menu-header small text-uppercase"><span class="menu-header-text">About</span></li>
    <li class="menu-item">
      <a
        href=""
        target="_blank"
        class="menu-link"
        >
        <i class="menu-icon tf-icons bx bx-support"></i>
        <div data-i18n="Support">Support</div>
      </a>
    </li>
    <li class="menu-item">
      <form action="/logout" method="POST">
        @csrf
        <button type="submit" class="menu-link bg-white border-0">
          <i class="menu-icon tf-icons bx bx-power-off"></i>
          <div data-i18n="Documentation">Log Out</div>
        </button>
      </form>
    </li>
  </ul>
</aside>
