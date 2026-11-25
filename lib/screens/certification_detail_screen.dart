import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/certification.dart';

class CertificationDetailScreen extends StatelessWidget {
  const CertificationDetailScreen({required this.certification, super.key});

  final Certification certification;

  @override
  Widget build(BuildContext context) {
    final hasThumbnail = certification.thumbnail.trim().isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          certification.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hasThumbnail) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  certification.thumbnail,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: double.infinity,
                    height: 160,
                    color: Colors.grey.shade200,
                    alignment: Alignment.center,
                    child: const Text('Gagal memuat gambar'),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
            Text(
              certification.title,
              style: Theme.of(context).textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Penerbit: ${certification.issuer}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              'Tanggal Diterbitkan: ${certification.dateIssued}',
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(color: Colors.grey.shade700),
            ),
            const Divider(height: 24),
            Text(
              certification.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
