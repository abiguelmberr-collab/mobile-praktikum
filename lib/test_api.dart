import 'dart:convert';

import 'package:http/http.dart' as http;
import 'models/course.dart';

const String apiUrl = 'https://jsonplaceholder.typicode.com/posts';

Future<List<Course>> fetchCourses() async {
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final List<dynamic> jsonList =
        jsonDecode(response.body) as List<dynamic>;

    return jsonList.map((item) {
      final post = item as Map<String, dynamic>;

      // Memetakan field dari JSONPlaceholder ke model Course.
      final courseJson = <String, dynamic>{
        'id': post['id'],
        'code': 'POST-${post['id']}',
        'title': post['title'],
        'credits': 3,
        'status': 'planned',
      };

      return Course.fromJson(courseJson);
    }).toList();
  }

  throw Exception('HTTP ${response.statusCode}');
}