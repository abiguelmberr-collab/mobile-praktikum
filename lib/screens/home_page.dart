
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../course_state.dart';
import '../constants/student_info.dart';
import '../providers/course_provider.dart';
import '../widgets/course_card.dart';
import 'course_detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final courseState = context.watch<CourseState>();
    final courseProvider = context.watch<CourseProvider>();

    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    // Konversi model Course menjadi Map agar cocok dengan CourseCard
    // dan CourseDetailPage yang sudah ada.
    final List<Map<String, dynamic>> courseList =
        courseProvider.courses.map<Map<String, dynamic>>((course) {
      return <String, dynamic>{
        'code': course.code,
        'title': course.title,
        'credits': course.credits,
        'status': course.status,
        'description': '',
      };
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Explorer'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          String layout;

          if (constraints.maxWidth < 600) {
            layout = 'Compact';
          } else if (constraints.maxWidth < 840) {
            layout = 'Medium';
          } else {
            layout = 'Expanded';
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // STATUS PEMUATAN DATA
                if (courseProvider.isLoading)
                  const Card(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: Column(
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 12),
                            Text('Memuat data course...'),
                          ],
                        ),
                      ),
                    ),
                  )
                else if (courseProvider.error != null)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Gagal memuat data course',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(courseProvider.error!),
                          const SizedBox(height: 8),
                          ElevatedButton.icon(
                            onPressed: () {
                              context
                                  .read<CourseProvider>()
                                  .loadCourses();
                            },
                            icon: const Icon(Icons.refresh),
                            label: const Text('Coba Lagi'),
                          ),
                        ],
                      ),
                    ),
                  )
                else if (courseList.isNotEmpty)
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.school),
                      title: Text(courseList.first['title'] as String),
                      subtitle: Text(
                        '${courseList.first['code']} • '
                        '${courseList.first['credits']} SKS • '
                        '${courseList.first['status']}',
                      ),
                    ),
                  )
                else
                  const Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('Belum ada course.'),
                    ),
                  ),

                const SizedBox(height: 16),

                // PROFIL MAHASISWA
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 38,
                          backgroundImage: AssetImage(
                            'assets/images/profile.png',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                studentName,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text('NIM: $studentId'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // INFORMASI LAYAR RESPONSIF
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Informasi Layar',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('Nama: $studentName'),
                        Text('NIM: $studentId'),
                        Text('Width: ${size.width.toStringAsFixed(0)}'),
                        Text('Height: ${size.height.toStringAsFixed(0)}'),
                        Text('Orientation: $orientation'),
                        Text('Layout: $layout'),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // PROGRESS DAN STATUS
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Progress',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${courseList.where((course) => course['status'] == 'Selesai').length}'
                                ' / ${courseList.length} Course',
                              ),
                              const SizedBox(height: 8),
                              LinearProgressIndicator(
                                value: courseList.isEmpty
                                    ? 0
                                    : courseList.where(
                                        (course) =>
                                            course['status'] == 'Selesai',
                                      ).length /
                                        courseList.length,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Card(
                        child: const Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Status',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text('Aktif'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // SKILL
                const Text(
                  'Skill',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Chip(
                      avatar: Icon(Icons.code, size: 18),
                      label: Text('Flutter'),
                    ),
                    Chip(
                      avatar: Icon(Icons.code, size: 18),
                      label: Text('Dart'),
                    ),
                    Chip(
                      avatar: Icon(Icons.storage, size: 18),
                      label: Text('Git'),
                    ),
                    Chip(
                      avatar: Icon(Icons.design_services, size: 18),
                      label: Text('UI Design'),
                    ),
                    Chip(
                      avatar: Icon(Icons.devices, size: 18),
                      label: Text('Responsive'),
                    ),
                    Chip(
                      avatar: Icon(Icons.cloud, size: 18),
                      label: Text('Firebase'),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // DAFTAR COURSE DARI PROVIDER
                const Text(
                  'Course Saya',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                if (courseProvider.isLoading)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(),
                    ),
                  )
                else if (courseProvider.error != null)
                  const Text(
                    'Daftar course belum tersedia. Periksa pesan error di atas.',
                  )
                else if (courseList.isEmpty)
                  const Text('Belum ada course yang tersedia.')
                else
                  for (final course in courseList.take(3))
                    CourseCard(
                      course: course,
                      isFavorite: courseState.isFavorite(
                        course['code'] as String,
                      ),
                      onFavorite: () {
                        context.read<CourseState>().toggleFavorite(
                              course['code'] as String,
                            );
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
                    ),
              ],
            ),
          );
        },
      ),
    );
  }
}
