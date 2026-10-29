
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../course_state.dart';

class CourseDetailPage extends StatefulWidget {
  final Map<String, dynamic> course;

  const CourseDetailPage({
    super.key,
    required this.course,
  });

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  @override
  Widget build(BuildContext context) {
    final course = widget.course;
    final code = course['code']?.toString() ?? '';
    final isFavorite =
        context.watch<CourseState>().favorites.contains(code);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Course'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<CourseState>().toggleFavorite(code);
              final nowFavorite = context
                  .read<CourseState>()
                  .favorites
                  .contains(code);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    nowFavorite
                        ? 'Course ditambahkan ke favorit'
                        : 'Course dihapus dari favorit',
                  ),
                ),
              );
            },
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course['title']?.toString() ?? 'Tanpa Judul',
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            InfoRow(title: 'Kode', value: course['code'].toString()),
            InfoRow(
              title: 'SKS',
              value: '${course['credits']}',
            ),
            InfoRow(title: 'Status', value: course['status'].toString()),
            const SizedBox(height: 20),
            const Text(
              'Deskripsi',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              course['description']?.toString() ??
                  'Tidak ada deskripsi.',
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Kembali'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const InfoRow({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
