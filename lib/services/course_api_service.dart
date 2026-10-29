import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/course.dart';
import 'course_data_source.dart';

class CourseApiService implements CourseDataSource {
  CourseApiService(this.baseUrl);

  final String baseUrl;
  @override
  Future<List<Course>> getCourses() async {
    final response = await http.get(Uri.parse('$baseUrl/posts'));

    if (response.statusCode != 200) {
      throw Exception('Gagal mengambil course: HTTP ${response.statusCode}');
    }

    final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;

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
  @override
  Future<Course> createCourse(Course course) async {
    final response = await http.post(
      Uri.parse('$baseUrl/posts'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': course.title,
        'body': course.code,
        'userId': 1,
      }),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;

      return Course(
        id: data['id'] as int?,
        code: course.code,
        title: course.title,
        credits: course.credits,
        status: course.status,
      );
    }

    throw Exception('Gagal membuat course');
  }
  @override
  Future<void> updateCourse(int id, Course course) async {
  final response = await http.put(
    Uri.parse('$baseUrl/posts/$id'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(course.toJson()),
  );

  if (response.statusCode < 200 ||
      response.statusCode >= 300) {
    throw Exception('Gagal memperbarui course');
  }
}
@override
Future<void> deleteCourse(int id) async {
  final response = await http.delete(
    Uri.parse('$baseUrl/posts/$id'),
  );

  if (response.statusCode < 200 ||
      response.statusCode >= 300) {
    throw Exception('Gagal menghapus course');
  }
}

}
