# CustomerApps

Deskripsi singkat proyek Anda.

## Daftar Isi

- [Tentang Proyek](#tentang-proyek)
- [Fitur](#fitur)
- [Teknologi yang Digunakan](#teknologi-yang-digunakan)
- [Persyaratan Sistem](#persyaratan-sistem)
- [Instalasi](#instalasi)
  - [Backend (Laravel)](#backend-laravel)
  - [Frontend (Flutter)](#frontend-flutter)
- [Pengguna](#pengguna)

## Tentang Proyek

Berikan penjelasan singkat mengenai tujuan dan fungsi dari proyek Anda.

## Fitur

- Manejemen Customers
- Tambah Outlet
- Login dan Logout
- Web dan Mobile

## Teknologi yang Digunakan

### Backend

- [Laravel](https://laravel.com/)

### Frontend

- [Flutter](https://flutter.dev/)

## Persyaratan Sistem

- PHP >= 7.3
- Composer
- Node.js dengan npm
- Flutter SDK
- Android Studio atau Xcode (untuk development mobile)

## Instalasi

### Backend (Laravel)

1. Clone repositori ini
   ```sh
   https://github.com/hoyirul/customer-apps.git
   ```
2. Masuk ke direktori backend
   ```sh
   cd backend
   ```
3. Instal dependensi
   ```sh
   composer install
   ```
4. Salin file .env.example menjadi .env
   ```sh
   cp .env.example .env
   ```
5. Generate aplikasi key
   ```sh
   php artisan generate:key
   ```
6. Atur konfigurasi database di file .env
   ```sh
    DB_DATABASE=db_custs
    DB_USERNAME=root
    DB_PASSWORD=root
   ```
7. Migrasi dan seed database
   ```sh
   php artisan migrate --seed
   ```
8. Jalankan server pengembangan
   ```sh
   php artisan serve --host [yourip] --port [yourport]
   ```

### Frontend (Flutter)

1. Masuk ke direktori frontend
   ```sh
   cd frontend
   ```
2. Instal dependensi
   ```sh
   flutter pub get
   ```
3. Jalankan Aplikasi
   ```sh
   flutter run
   ```
## Pengguna
email : cust2@test.com
password : password

admin panel
email : admin@test.com
password : password
