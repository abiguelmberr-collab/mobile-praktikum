
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../course_state.dart';
import '../data/courses.dart';
import '../widgets/course_card.dart';
import 'course_detail_page.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final courseState = context.watch<CourseState>();

    final favoriteCourses = courses.where((course) {
      return courseState.isFavorite(course['code'] as String);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Favorit'),
      ),
      body: favoriteCourses.isEmpty
          ? const Center(
              child: Text('Belum ada course favorit.'),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favoriteCourses.length,
              itemBuilder: (context, index) {
                final course = favoriteCourses[index];
                final code = course['code'] as String;

                return CourseCard(
                  course: course,
                  isFavorite: courseState.isFavorite(code),
                  onFavorite: () {
                    context.read<CourseState>().toggleFavorite(code);
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CourseDetailPage(
                          course: course,
                        ),
                      ),
                    );
                  },
                  onLongPress: () {},
                );
              },
            ),
    );
  }
}

