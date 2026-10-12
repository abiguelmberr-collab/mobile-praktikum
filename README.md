# flutter_application_1

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
## Struktur Arsitektur Aplikasi

Aplikasi Course Explorer menggunakan pemisahan tanggung jawab (*separation of concerns*) agar kode lebih terstruktur dan mudah dikembangkan.

### Tanggung Jawab Folder

- **models/**: Menyimpan model data Course.
- **services/**: Mengambil dan memproses data dari sumber data, seperti file JSON.
- **repositories/**: Menjadi perantara antara Provider dan Service.
- **providers/**: Mengelola state aplikasi, proses loading, error, dan data course.
- **screens/**: Menyimpan halaman utama aplikasi.
- **widgets/**: Menyimpan komponen UI yang dapat digunakan kembali.

### Arah Dependency

Arah dependency aplikasi adalah:

`Screen/Widget → Provider → Repository → Service/Data Source`

Dengan struktur ini, UI tidak mengambil data secara langsung menggunakan `rootBundle` atau `jsonDecode`. Setiap layer memiliki tanggung jawab yang jelas sehingga aplikasi lebih mudah dirawat dan dikembangkan.