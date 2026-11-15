Nama : Darrel Rifathir Arwa
NPM  : 2506536420
Kelas: C

# My Portofolio Mobile
Repositori ini berisi kode untuk aplikasi *mobile* portofolio pribadi berbasis multiplatform, dibangun menggunakan *framework* **Flutter** dan bahasa pemrograman **Dart**.

# Tugas 7
## Instruksi Setup Mingguan:

**Cara Instalasi dan Menjalankan Proyek Secara Lokal:**
1.  **Pastikan prasyarat lingkungan pengembangan telah terpasang:**
    Pastikan **Flutter SDK** sudah terpasang dan terdaftar pada *Environment Variables* (`PATH`), serta terverifikasi melalui perintah:
    ```bash
    flutter doctor
    ```
2.  **Kloning repositori:**
    ```bash
    git clone [https://github.com/darrelrifathir/myportofolio_mobile.git](https://github.com/darrelrifathir/myportofolio_mobile.git)
    cd myportofolio_mobile
    ```
3.  **Instalasi *dependencies* (paket Flutter):**
    ```bash
    flutter pub get
    ```
4.  **Jalankan aplikasi secara lokal:**
    *   **Melalui peramban Google Chrome:**
        ```bash
        flutter run -d chrome
        ```
    *   **Melalui Android Emulator atau perangkat fisik (pastikan emulator aktif / USB Debugging menyala):**
        ```bash
        flutter run
        ```
5.  **Analisis statis kualitas kode (opsional):**
    ```bash
    flutter analyze
    ```

---
## Jawaban Pertanyaan Reflektif

### 1. Jelaskan apa yang dimaksud dengan widget tree pada Flutter dan bagaimana hubungan induk-anak (parent-child) bekerja antar-widget!
*Widget tree* adalah struktur hierarki berbentuk pohon yang merepresentasikan susunan seluruh elemen antarmuka pengguna (*User Interface*) di dalam aplikasi Flutter. Karena Flutter mengusung prinsip *"everything is a widget"*, komponen visual (seperti `Text` dan `Icon`), pengatur tata letak (`Column`, `Row`, `Padding`), hingga struktur dasar halaman (`Scaffold` dan `MaterialApp`) semuanya disusun bertingkat sebagai simpul (*node*) dalam pohon tersebut.

Hubungan induk-anak (*parent-child*) bekerja melalui komposisi properti `child` (untuk widget yang hanya menampung satu anak, seperti `Center`, `Padding`, atau `Card`) dan `children` (untuk widget yang menampung banyak anak dalam bentuk `List<Widget>`, seperti `Column`, `Row`, atau `GridView`). Dalam mekanisme rendering tata letaknya, **parent** meneruskan batasan ukuran (*constraints* berupa lebar dan tinggi minimum/maksimum) ke bawah menuju **child**, lalu **child** menentukan ukurannya sendiri sesuai batasan tersebut dan mengembalikannya ke **parent**, hingga akhirnya **parent** menetapkan posisi koordinat masing-masing **child** di layar (*"Constraints go down. Sizes go up. Parent sets position"*).

### 2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya masing-masing!
Berikut adalah seluruh widget yang digunakan di dalam berkas `lib/main.dart` dan `lib/menu.dart` pada proyek `myportofolio_mobile`:

*   **`MyApp` (`StatelessWidget`):** Widget kustom yang menjadi titik awal (*root*) struktur aplikasi dan membungkus konfigurasi `MaterialApp`.
*   **`MaterialApp`:** Widget bawaan Flutter yang menyediakan fondasi *Material Design*, pengaturan tema warna global (`ThemeData`), judul aplikasi, serta navigasi ke halaman beranda (`home`).
*   **`MyHomePage` (`StatelessWidget`):** Widget kustom yang merepresentasikan halaman menu utama portofolio mobile.
*   **`Scaffold`:** Widget kerangka struktur visual dasar halaman Material Design yang menyediakan tata letak untuk `AppBar`, `body`, dan `SnackBar`.
*   **`AppBar`:** Bilah navigasi di bagian atas halaman yang menampilkan judul aplikasi (`MyPortfolio`) dengan warna latar primer.
*   **`Text`:** Widget untuk merender untaian karakter teks di layar (digunakan pada judul `AppBar`, isi `InfoCard`, pesan sambutan, label tombol `ItemCard`, dan isi `SnackBar`).
*   **`Padding`:** Widget tata letak yang memberikan ruang kosong (*inset*) di sekeliling widget anaknya.
*   **`Column`:** Widget tata letak yang menyusun daftar widget anaknya secara vertikal dari atas ke bawah.
*   **`Row`:** Widget tata letak yang menyusun daftar widget anaknya secara horizontal dari kiri ke kanan (digunakan untuk menyejajarkan tiga `InfoCard`).
*   **`InfoCard` (`StatelessWidget`):** Widget kustom yang dapat digunakan kembali (*reusable*) untuk menampilkan kartu identitas pemilik portofolio (`NPM`, `Name`, dan `Class`).
*   **`Card`:** Widget kontainer bergaya Material Design dengan sudut melengkung dan efek bayangan (*elevation*) untuk membungkus informasi pada `InfoCard`.
*   **`Container`:** Widget serbaguna untuk mengatur lebar adaptif (`width`), `padding`, dan posisi komponen di dalamnya.
*   **`SizedBox`:** Widget kotak berdimensi tetap yang dimanfaatkan untuk memberikan jarak spasi vertikal antar-elemen.
*   **`Center`:** Widget tata letak yang memposisikan widget anaknya tepat di tengah ruang yang tersedia.
*   **`GridView` (`GridView.count`):** Widget tata letak kisi (*grid*) dua dimensi yang menyusun daftar kartu aksi ke dalam 3 kolom sejajar.
*   **`ItemCard` (`StatelessWidget`):** Widget kustom *reusable* yang merepresentasikan kartu tombol menu aksi interaktif portofolio.
*   **`Material`:** Widget permukaan bergaya Material Design yang memberikan warna latar unik (`item.color`) dan sudut membulat (`borderRadius`), sekaligus menjadi kanvas bagi efek sentuh `InkWell`.
*   **`InkWell`:** Widget pendeteksi interaksi sentuhan atau klik pengguna (`onTap`) yang memunculkan animasi gelombang air (*ripple effect*).
*   **`Icon`:** Widget untuk menampilkan ikon grafis Material (ikon folder, tambah, dan logout) pada `ItemCard`.
*   **`SnackBar`:** Widget notifikasi ringan yang muncul melayang di bagian bawah layar untuk memberikan umpan balik visual ketika pengguna menekan tombol menu.

### 3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini umumnya digunakan sebagai root widget pada aplikasi Flutter!
`MaterialApp` adalah widget tingkat atas bawaan Flutter yang membungkus keseluruhan aplikasi dan menyediakan berbagai fungsionalitas inti untuk aplikasi yang mengikuti standar *Material Design*. Fungsi utamanya meliputi pengelolaan tema visual global (`ThemeData` seperti skema warna *Material 3* dan tipografi), sistem navigasi antar-halaman (*routing* melalui `Navigator` dan properti `home`), lokalisasi bahasa, serta penyediaan akses konteks bagi komponen antarmuka seperti `Scaffold` dan `SnackBar`.

`MaterialApp` umumnya ditempatkan sebagai *root widget* (widget paling puncak dalam *widget tree*) agar seluruh widget turunan (*descendants*) di bawahnya dapat mewarisi dan mengakses konfigurasi tema (`Theme.of(context)`), arah baca teks (`Directionality`), dan sistem navigasi secara konsisten tanpa perlu mendefinisikannya berulang kali di setiap halaman. Tanpa `MaterialApp` di puncak pohon, komponen Material seperti `Scaffold`, `Text`, atau `InkWell` akan mengalami *error* karena kehilangan konteks tema dan arah tata letak.

### 4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget! Kapan kita sebaiknya memilih StatelessWidget dan kapan harus menggunakan StatefulWidget?
Perbedaan utama antara `StatelessWidget` dan `StatefulWidget` terletak pada sifat mutabilitas data (*state*) internalnya selama siklus hidup (*lifecycle*) widget tersebut berlangsung:

*   **`StatelessWidget`** bersifat tidak dapat diubah (*immutable*). Widget ini hanya membangun antarmuka berdasarkan parameter konfigurasi yang diterima melalui konstruktornya dan tidak memiliki objek `State` terpisah yang dapat memicu pembaruan tampilan secara mandiri.
*   **`StatefulWidget`** bersifat dinamis dan memiliki objek `State` terpisah untuk menyimpan data yang dapat berubah selama aplikasi berjalan. Ketika data di dalam objek `State` dimutasi melalui pemanggilan fungsi `setState()`, Flutter akan menandai widget tersebut sebagai *dirty* dan memanggil ulang metode `build()` untuk memperbarui tampilan layar secara otomatis.

**Kapan memilih masing-masing:**
*   Pilih **`StatelessWidget`** ketika tampilan antarmuka bersifat statis atau hanya bergantung pada nilai yang dikirim dari induknya tanpa perlu berubah akibat interaksi internal, seperti pada halaman beranda `MyHomePage`, kartu profil `InfoCard`, dan kartu tombol `ItemCard` pada proyek ini. Pendekatan ini membuat struktur kode lebih ringkas dan hemat memori.
*   Pilih **`StatefulWidget`** ketika antarmuka perlu merespons interaksi pengguna atau perubahan data secara *real-time* di halaman tersebut, seperti halaman formulir dengan input teks yang berubah-ubah, *counter*, *checkbox*, animasi, maupun halaman yang memuat data asinkronus dari REST API.

### 5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di dalam metode build?
`BuildContext` adalah sebuah objek referensi (*handle*) yang merepresentasikan lokasi spesifik dari sebuah widget di dalam hierarki *widget tree*. Setiap widget di Flutter memiliki `BuildContext`-nya masing-masing yang terhubung langsung dengan elemen induk (*ancestor*) di atasnya.

`BuildContext` sangat penting karena menjadi mekanisme komunikasi ke atas di dalam *widget tree*. Melalui `BuildContext`, sebuah widget dapat mencari dan mengambil konfigurasi atau layanan yang disediakan oleh *ancestor widget* tanpa harus mengoper parameter secara manual melewati banyak tingkat konstruktor (*prop drilling*).

Di dalam metode `build(BuildContext context)`, parameter `context` digunakan untuk memanggil metode statis `.of(context)` pada berbagai kelas utilitas Flutter. Pada proyek ini, `context` dimanfaatkan untuk:
*   Mengambil warna tema utama aplikasi melalui `Theme.of(context).colorScheme.primary` pada `AppBar`.
*   Membaca dimensi lebar layar perangkat secara adaptif melalui `MediaQuery.of(context).size.width` pada `InfoCard`.
*   Mengakses pengelola notifikasi layar untuk memunculkan `SnackBar` melalui `ScaffoldMessenger.of(context)` pada `ItemCard`.

### 6. Jelaskan konsep hot reload di Flutter dan apa perbedaannya dengan hot restart! Kapan kita tidak bisa hanya mengandalkan hot reload dan harus melakukan hot restart atau full restart?
*Hot Reload* adalah fitur pengembangan Flutter berbasis kompilasi *Just-In-Time* (JIT) yang menyuntikkan berkas kode sumber Dart yang baru diubah langsung ke dalam *Dart Virtual Machine* (VM) yang sedang berjalan. Setelah VM memperbarui definisi kelas dan fungsi, framework Flutter secara otomatis membangun ulang *widget tree* dalam hitungan milidetik sambil **tetap mempertahankan *state* aplikasi saat ini** (seperti posisi *scroll* atau nilai variabel yang sedang aktif).

**Perbedaan dengan *Hot Restart*:** Jika *Hot Reload* mempertahankan *state* aplikasi yang sedang berjalan, ***Hot Restart*** akan mengompilasi ulang kode Dart dan me-reset seluruh *state* aplikasi kembali ke kondisi awal (menjalankan ulang fungsi `main()` dari nol), meskipun prosesnya tetap jauh lebih cepat dibandingkan kompilasi ulang penuh dari sisi native.

**Kapan tidak bisa hanya mengandalkan *Hot Reload*:**
*   **Harus melakukan *Hot Restart*:** Ketika perubahan dilakukan pada bagian inisialisasi global aplikasi, seperti memodifikasi fungsi `main()`, mengubah properti atau tema pada `MyApp` sebelum widget dibangun, menambahkan variabel *state* baru atau mengubah logika awal di dalam `initState()`, serta mengubah tipe widget dari `StatelessWidget` menjadi `StatefulWidget` (atau sebaliknya).
*   **Harus melakukan *Full Restart* (menghentikan lalu menjalankan ulang `flutter run`):** Ketika menambahkan dependensi paket baru di berkas `pubspec.yaml`, menambahkan aset statis baru (seperti gambar atau font), atau melakukan perubahan pada konfigurasi *native* platform (seperti `AndroidManifest.xml`, pengaturan Gradle Android, atau berkas konfigurasi iOS).

---

## AI Disclosure & Log Prompting
Dalam pengembangan Tugas 7 ini, saya menggunakan asisten AI sebagai rekan diskusi teknis untuk membantu penyiapan environment pengembangan baru di Flutter dan Dart, khususnya dalam mendiagnosis konfigurasi *environment variable* serta mempercantik umpan balik visual pada komponen antarmuka.

*   **Tools yang Digunakan:** Gemini 4.0 Hydrogen
*   **Strategi Prompting:** Saya memosisikan AI sebagai mitra *troubleshooting* dengan melampirkan tangkapan layar (*screenshot*) kendala terminal secara langsung untuk mempercepat proses diagnosis galat teknis, serta meminta saran kustomisasi UI yang selaras dengan skema warna kartu.
*   **Bagian Spesifik yang Dibantu AI:**
    *   Mendiagnosis masalah konfigurasi jalur *Environment Variables* (`PATH`) di Windows yang sempat tertukar antara instalasi mandiri `dart-sdk` dengan folder `bin` utama milik Flutter SDK.
    *   Membantu menyusun kustomisasi tampilan `SnackBar` melayang (*floating*) dengan warna latar dinamis (`backgroundColor: item.color`) agar selaras dengan warna masing-masing kartu tombol `ItemCard`.
*   **Analisis Kritis Keterbatasan AI & Perbaikan Manual:** 
    AI sempat memberikan tautan dokumentasi instalasi yang tidak langsung mengarah ke berkas arsip unduhan Flutter SDK untuk Windows, serta menyertakan data contoh bawaan tutorial. Selain itu, AI sempat menyarankan penambahan *wrapper* `SingleChildScrollView` untuk mengantisipasi potensi *layout overflow* pada layar desktop. Sebagai perbaikan manual, saya menelusuri halaman arsip rilis resmi Flutter secara mandiri untuk mengunduh bundel stabil (`3.47.9`), membersihkan sisa jalur `dart-sdk` pada *Environment Variables*, menyesuaikan seluruh data `InfoCard` dengan identitas pribadi saya, serta memverifikasi tampilan aplikasi melalui peramban Microsoft Edge—yang menampilkan seluruh kartu secara proporsional tanpa *overflow*—sehingga saya mempertahankan struktur *layout* asli sesuai modul tanpa menambahkan widget *scroll* yang tidak diperlukan.
*   **Log Prompting:**
    *   *Prompt 1:* "ini udah bener belom path nya? atau gw ada ekstraknya salah ya [Melampirkan screenshot Environment Variables dan folder dart-sdk\bin]"
        *   *Respons AI:* AI mengidentifikasi bahwa berkas yang diekstrak baru berupa Dart SDK mandiri sehingga perintah `flutter` belum dikenali, lalu memandu saya mengekstrak bundel penuh Flutter SDK ke `C:\src\flutter` dan mengarahkan `PATH` ke `C:\src\flutter\bin`.
    *   *Prompt 2:* "oiya gw mau dong buat perbagus aja, bagian toast buat notifikasi kalo ngeklik tombol di bedain warnanya gitu biar lebih bagus, gak hitam doang"
        *   *Respons AI:* AI memberikan saran penggunaan properti `backgroundColor: item.color`, `behavior: SnackBarBehavior.floating`, dan `RoundedRectangleBorder` pada widget `SnackBar` di dalam `ItemCard`.
