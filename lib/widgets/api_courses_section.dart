
import 'package:flutter/material.dart';

import '../models/course.dart';
import '../services/course_api_service.dart';

class ApiCoursesSection extends StatefulWidget {
  const ApiCoursesSection({super.key});

  @override
  State<ApiCoursesSection> createState() =>
      _ApiCoursesSectionState();
}

class _ApiCoursesSectionState extends State<ApiCoursesSection> {
  final CourseApiService _apiService = CourseApiService(
    'https://jsonplaceholder.typicode.com',
  );

  List<Course> _courses = [];
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _loadCourses() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final courses = await _apiService.getCourses();

      if (!mounted) return;

      setState(() {
        _courses = courses.take(3).toList();
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Data Course dari REST API',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _loadCourses,
              icon: const Icon(Icons.cloud_download),
              label: Text(
                _isLoading ? 'Memuat...' : 'Ambil 3 Data API',
              ),
            ),
            if (_isLoading) ...[
              const SizedBox(height: 12),
              const Center(
                child: CircularProgressIndicator(),
              ),
            ],
            if (_errorMessage != null) ...[
              const SizedBox(height: 12),
              Text('Gagal mengambil data: $_errorMessage'),
            ],
            if (_courses.isNotEmpty) ...[
              const SizedBox(height: 12),
              for (final course in _courses)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    child: Text('${course.id ?? '-'}'),
                  ),
                  title: Text(course.title),
                  subtitle: Text(
                    '${course.code} • ${course.credits} SKS • '
                    '${course.status}',
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
