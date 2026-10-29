
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../course_state.dart';
import '../providers/course_provider.dart';
import '../widgets/course_card.dart';
import 'course_detail_page.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final courseState = context.watch<CourseState>();
    final courseProvider = context.watch<CourseProvider>();

    final favoriteCourses = courseProvider.courses.where((course) {
      return courseState.isFavorite(course.code);
    }).toList();

    if (courseProvider.isLoading && courseProvider.courses.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (courseProvider.error != null &&
        courseProvider.courses.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Course Favorit')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Gagal memuat course favorit.'),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () =>
                    context.read<CourseProvider>().loadCourses(),
                child: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),
      );
    }

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

                return CourseCard(
                  course: {
                    'code': course.code,
                    'title': course.title,
                    'credits': course.credits,
                    'status': course.status,
                  },
                  isFavorite: courseState.isFavorite(course.code),
                  onFavorite: () {
                    context
                        .read<CourseState>()
                        .toggleFavorite(course.code);
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CourseDetailPage(
                          course: {
                            'code': course.code,
                            'title': course.title,
                            'credits': course.credits,
                            'status': course.status,
                          },
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
