import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/certification.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class CertificationFormPage extends StatefulWidget {
  const CertificationFormPage({super.key});

  @override
  State<CertificationFormPage> createState() => _CertificationFormPageState();
}

class _CertificationFormPageState extends State<CertificationFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = "";
  String _issuer = "";
  String _dateIssued = "";
  String _description = "";
  String _thumbnail = "";
  bool _isSubmitting = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final ok = await ensureLoggedIn(context);
    if (!ok || !mounted) return;

    final authState = context.read<AuthState>();
    final token = authState.token;
    if (token == null) return;

    setState(() {
      _isSubmitting = true;
    });

    final newCertification = Certification(
      title: _title.trim(),
      issuer: _issuer.trim(),
      dateIssued: _dateIssued.trim(),
      description: _description.trim(),
      thumbnail: _thumbnail.trim(),
    );

    try {
      final created = await context.read<ApiClient>().createCertification(
        newCertification,
        token: token,
      );
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Sertifikasi berhasil ditambahkan!'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nama Sertifikasi: ${created.title}'),
                  Text('Penerbit: ${created.issuer}'),
                  Text('Tanggal Diterbitkan: ${created.dateIssued}'),
                  Text('Deskripsi: ${created.description}'),
                  Text(
                    'URL Gambar: ${created.thumbnail.isEmpty ? "-" : created.thumbnail}',
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                  _formKey.currentState!.reset();
                  setState(() {
                    _title = "";
                    _issuer = "";
                    _dateIssued = "";
                    _description = "";
                    _thumbnail = "";
                  });
                },
              ),
            ],
          );
        },
      );
    } on ApiException catch (e) {
      if (!mounted) return;
      if (e.statusCode == 401) {
        await authState.logout();
        if (!mounted) return;
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text('Sesi berakhir. Silakan login kembali.'),
            ),
          );
        await ensureLoggedIn(context);
      } else {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(
                'Gagal menyimpan sertifikasi (status ${e.statusCode}).',
              ),
            ),
          );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text('Terjadi kesalahan koneksi: $e')),
        );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Add Certification Form',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Title (Nama Sertifikasi) ===
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Contoh: CS50x",
                    labelText: "Nama Sertifikasi",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _title = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Nama sertifikasi tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // === Issuer (Penerbit Sertifikasi) ===
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Contoh: Harvard University",
                    labelText: "Penerbit Sertifikasi",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _issuer = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Penerbit sertifikasi tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // === Date Issued (Tanggal diterbitkan) ===
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "YYYY-MM-DD (Contoh: 2026-11-25)",
                    labelText: "Tanggal diterbitkan",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _dateIssued = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Tanggal diterbitkan tidak boleh kosong!";
                    }
                    final dateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
                    if (!dateRegex.hasMatch(value.trim())) {
                      return "Gunakan format tanggal YYYY-MM-DD!";
                    }
                    return null;
                  },
                ),
              ),

              // === Description (Deskripsi Sertifikasi) ===
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Deskripsi singkat tentang sertifikasi ini...",
                    labelText: "Deskripsi Sertifikasi",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _description = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Deskripsi sertifikasi tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // === Thumbnail (URL gambar - Opsional) ===
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                    hintText: "https://... (opsional)",
                    labelText: "URL gambar",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _thumbnail = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value != null && value.trim().isNotEmpty) {
                      final uri = Uri.tryParse(value.trim());
                      if (uri == null ||
                          !(uri.isScheme('http') || uri.isScheme('https')) ||
                          uri.host.isEmpty) {
                        return "Format URL tidak valid! Gunakan http:// atau https://";
                      }
                    }
                    return null;
                  },
                ),
              ),

              // === Tombol Simpan ===
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    onPressed: _isSubmitting ? null : _submit,
                    child: _isSubmitting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            "Save",
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
