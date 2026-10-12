
import 'package:flutter/material.dart';

class CourseCard extends StatefulWidget {
  final Map<String, dynamic> course;
  final bool isFavorite;
  final VoidCallback onFavorite;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const CourseCard({
    super.key,
    required this.course,
    required this.isFavorite,
    required this.onFavorite,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final course = widget.course;

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: widget.onTap,
        onLongPress: widget.onLongPress,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      course['title'] as String,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: widget.onFavorite,
                    icon: Icon(
                      widget.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '${course['code']} • ${course['credits']} SKS',
              ),
              const SizedBox(height: 8),
              Text(
                course['status'] as String,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: course['status'] == 'Selesai'
                      ? Colors.green
                      : course['status'] == 'Aktif'
                          ? Colors.blue
                          : Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  icon: Icon(
                    isExpanded
                        ? Icons.expand_less
                        : Icons.expand_more,
                  ),
                  label: Text(
                    isExpanded
                        ? 'Sembunyikan detail'
                        : 'Lihat deskripsi',
                  ),
                ),
              ),
              if (isExpanded) ...[
                const Divider(),
                Text(
                  course['description'] ?? 'Tidak ada deskripsi.',
                  style: const TextStyle(height: 1.4),
                ),
              ],
              const SizedBox(height: 4),
              const Text(
                'Tap kartu untuk membuka halaman detail',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
