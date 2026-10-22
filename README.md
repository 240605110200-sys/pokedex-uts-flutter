# Pokedex UTS

**Deskripsi Singkat Aplikasi**
Aplikasi mobile berbasis Flutter yang menyajikan informasi karakter Pokemon secara dinamis. Aplikasi ini mengambil data secara langsung dari PokeAPI publik untuk menampilkan katalog karakter beserta detail spesifiknya menggunakan antarmuka yang interaktif.

**Fitur Utama**
- **Katalog Interaktif (Home):** Menampilkan daftar 20 karakter Pokemon pertama dalam bentuk *Grid layout* beserta gambar resminya.
- **Detail & Statistik:** Halaman khusus yang memuat tipe elemen (seperti Grass, Fire) dan status statistik dasar (HP, Attack, Defense, dll) menggunakan *Linear Progress Bar*.
- **Asynchronous UI:** Menerapkan `FutureBuilder` untuk menangani status *loading* saat mengambil data, status sukses, hingga penanganan pesan *error* jika koneksi gagal.

**Teknologi dan Package yang Digunakan**
- **Framework:** Flutter
- **Bahasa Pemrograman:** Dart
- **Package Eksternal:** `http` (versi ^1.1.0) untuk melakukan permintaan HTTP GET ke *endpoint* API.
- **Sumber Data:** RESTful API dari [PokeAPI](https://pokeapi.co/)

**Langkah Menjalankan Aplikasi**
1. Lakukan clone repositori ini ke komputer lokal menggunakan perintah:
   `git clone <link-repo-github-kamu>`
2. Buka folder proyek `pokedex_uts` melalui IDE (Visual Studio Code atau Android Studio).
3. Buka terminal di dalam IDE, lalu jalankan perintah berikut untuk mengunduh semua *package* yang dibutuhkan:
   `flutter pub get`
4. Pastikan emulator Android/iOS atau perangkat fisik sudah tersambung.
5. Jalankan aplikasi dengan menekan tombol **Run** di IDE atau mengetikkan perintah:
   `flutter run`