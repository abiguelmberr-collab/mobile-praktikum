import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/course.dart';

class CourseApiService {
  CourseApiService(this.baseUrl);

  final String baseUrl;

  Future<List<Course>> getCourses() async {
    final response = await http.get(
      Uri.parse('$baseUrl/posts'),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Gagal mengambil course: HTTP ${response.statusCode}',
      );
    }

    final List<dynamic> data =
        jsonDecode(response.body) as List<dynamic>;

    return data.map((item) {
      final post = item as Map<String, dynamic>;

      return Course.fromJson({
        'id': post['id'],
        'code': 'POST-${post['id']}',
        'title': post['title'],
        'credits': 3,
        'status': 'planned',
      });
    }).toList();
  }
}