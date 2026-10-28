import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'course_state.dart';
import 'screens/course_form_page.dart';
import 'models/course.dart';

import 'widgets/course_card.dart';

import 'data/courses.dart';

import 'screens/favorites_page.dart';

import 'providers/course_provider.dart';
import 'repositories/course_repository.dart';
import 'services/course_api_service.dart';

import 'test_api.dart';
import 'widgets/api_courses_section.dart';

import 'widgets/error_view.dart';

const String studentName = 'Made Gatan Pytrhsno Penar';

const String studentId = '2415051118';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CourseState()),
        ChangeNotifierProvider(
          create: (_) => CourseProvider(
            CourseRepository(
              CourseApiService('https://jsonplaceholder.typicode.com'),
            ),
          )..loadCourses(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

// =========================

// APP

// =========================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Course Explorer',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),

        useMaterial3: true,
      ),

      home: const MainPage(),
    );
  }
}

// =========================

// MAIN PAGE

// =========================

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    HomePage(),
    CoursesPage(),
    ProfilePage(),
    FavoritesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isExpanded = constraints.maxWidth >= 840;

        if (isExpanded) {
          return Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: selectedIndex,

                  onDestinationSelected: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },

                  labelType: NavigationRailLabelType.all,

                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),

                      selectedIcon: Icon(Icons.home),

                      label: Text('Home'),
                    ),

                    NavigationRailDestination(
                      icon: Icon(Icons.book_outlined),

                      selectedIcon: Icon(Icons.book),

                      label: Text('Courses'),
                    ),

                    NavigationRailDestination(
                      icon: Icon(Icons.person_outline),

                      selectedIcon: Icon(Icons.person),

                      label: Text('Profile'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.favorite_outline),
                      selectedIcon: Icon(Icons.favorite),
                      label: Text('Favorites'),
                    ),
                  ],
                ),

                const VerticalDivider(width: 1),

                Expanded(child: pages[selectedIndex]),
              ],
            ),
          );
        }

        return Scaffold(
          body: pages[selectedIndex],

          bottomNavigationBar: NavigationBar(
            selectedIndex: selectedIndex,

            onDestinationSelected: (index) {
              setState(() {
                selectedIndex = index;
              });
            },

            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),

                selectedIcon: Icon(Icons.home),

                label: 'Home',
              ),

              NavigationDestination(
                icon: Icon(Icons.book_outlined),

                selectedIcon: Icon(Icons.book),

                label: 'Courses',
              ),

              NavigationDestination(
                icon: Icon(Icons.person_outline),

                selectedIcon: Icon(Icons.person),

                label: 'Profile',
              ),

              NavigationDestination(
                icon: Icon(Icons.favorite_outline),
                selectedIcon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
            ],
          ),
        );
      },
    );
  }
}

// =========================

// HOME PAGE

// =========================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final firstCourse = Course.fromJson(courses.first);
    final size = MediaQuery.of(context).size;

    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(title: const Text('Course Explorer')),

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
                Card(
                  child: ListTile(
                    title: Text(firstCourse.title),
                    subtitle: Text(
                      '${firstCourse.code} • ${firstCourse.credits} SKS • ${firstCourse.status}',
                    ),
                  ),
                ),

                // =========================

                // PROFILE

                // =========================
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

                // =========================

                // MEDIA QUERY

                // =========================
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

                // =========================
                // EXPANDED
                // =========================
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
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              const Text('3 / 5 Course'),
                              const SizedBox(height: 8),
                              LinearProgressIndicator(
                                value: 0.6,
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
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Status',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              const Text('Aktif'),
                              const SizedBox(height: 16),

                              ElevatedButton.icon(
                                onPressed: () async {
                                  try {
                                    final data = await fetchCourses();

                                    if (!context.mounted) return;

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'GET berhasil: ${data.length} data diterima',
                                        ),
                                      ),
                                    );
                                  } catch (e) {
                                    if (!context.mounted) return;

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('GET gagal: $e')),
                                    );
                                  }
                                },
                                icon: const Icon(Icons.cloud_download),
                                label: const Text('Tes HTTP GET'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // =========================

                // WRAP

                // =========================
                const Text(
                  'Skill',

                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                Wrap(
                  spacing: 8,

                  runSpacing: 8,

                  children: const [
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
                const ApiCoursesSection(),
                const SizedBox(height: 16),

                // COURSE SAYA

                // =========================

                // COURSE SAYA

                // =========================
                const Text(
                  'Course Saya',

                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                for (final course in courses.take(3))
                  CourseCard(
                    course: course,

                    isFavorite: context.watch<CourseState>().favorites.contains(
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
                          builder: (context) =>
                              CourseDetailPage(course: course),
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

// =========================

// COURSES PAGE

// =========================

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Course'),
        actions: [
          IconButton(
            tooltip: 'Tambah Course',
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CourseFormPage()),
              );
            },
          ),
        ],
      ),

      body: Builder(
        builder: (context) {
          final apiState = context.watch<CourseProvider>();

          if (apiState.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (apiState.error != null) {
            return ErrorView(
              message: apiState.error!,
              onRetry: apiState.loadCourses,
            );
          }

          if (apiState.courses.isEmpty) {
            return const Center(child: Text('Data course belum tersedia'));
          }

          final apiCourses = apiState.courses;

          return LayoutBuilder(
            builder: (context, constraints) {
              final columnCount = constraints.maxWidth < 600
                  ? 1
                  : constraints.maxWidth < 840
                  ? 2
                  : 3;

              final courseMaps = apiCourses.map((course) {
                return <String, dynamic>{
                  'id': course.id,
                  'code': course.code,
                  'title': course.title,
                  'credits': course.credits,
                  'status': course.status,
                };
              }).toList();

              return GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: courseMaps.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columnCount,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: constraints.maxWidth < 600 ? 1.5 : 1.2,
                ),
                itemBuilder: (context, index) {
                  final course = courseMaps[index];
                  final code = course['code'] as String;

                  return CourseCard(
                    course: course,
                    isFavorite: context.watch<CourseState>().favorites.contains(
                      code,
                    ),
                    onFavorite: () {
                      context.read<CourseState>().toggleFavorite(code);

                      final isFavorite = context
                          .read<CourseState>()
                          .favorites
                          .contains(code);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isFavorite
                                ? '${course['title']} ditambahkan ke favorit'
                                : '${course['title']} dihapus dari favorit',
                          ),
                        ),
                      );
                    },
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CourseDetailPage(course: course),
                        ),
                      );
                    },
                    onLongPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CourseFormPage(
                            course: apiState.courses[index],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

// =========================

// COURSE CARD

// =========================

// =========================

// COURSE DETAIL

// =========================

class CourseDetailPage extends StatefulWidget {
  final Map<String, dynamic> course;

  const CourseDetailPage({super.key, required this.course});

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  @override
  Widget build(BuildContext context) {
    final course = widget.course;
    final code = course['code'] as String;
    final isFavorite = context.watch<CourseState>().favorites.contains(code);

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
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course['title'],
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            InfoRow(title: 'Kode', value: course['code']),
            InfoRow(title: 'SKS', value: '${course['credits']}'),
            InfoRow(title: 'Status', value: course['status']),
            const SizedBox(height: 20),
            const Text(
              'Deskripsi',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              course['description'],
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

// =========================

// INFO ROW

// =========================

class InfoRow extends StatelessWidget {
  final String title;

  final String value;

  const InfoRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          SizedBox(
            width: 80,

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

// =========================

// PROFILE PAGE

// =========================

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const CircleAvatar(
              radius: 55,

              backgroundImage: AssetImage('assets/images/profile.png'),
            ),

            const FavoriteCounter(),

            const SizedBox(height: 16),

            Text(
              studentName,

              textAlign: TextAlign.center,

              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 6),

            Text('NIM: $studentId', style: const TextStyle(fontSize: 16)),

            const SizedBox(height: 30),

            Card(
              child: ListTile(
                leading: const Icon(Icons.feedback),

                title: const Text('Feedback'),

                subtitle: const Text('Kirim feedback mengenai aplikasi'),

                trailing: const Icon(Icons.arrow_forward_ios),

                onTap: () {
                  Navigator.push(
                    context,

                    MaterialPageRoute(
                      builder: (context) => const FeedbackPage(),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Skill Saya',

              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Wrap(
              spacing: 8,

              runSpacing: 8,

              children: const [
                Chip(label: Text('Flutter')),

                Chip(label: Text('Dart')),

                Chip(label: Text('Git')),

                Chip(label: Text('UI Design')),

                Chip(label: Text('Firebase')),

                Chip(label: Text('Responsive')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// =========================

// FEEDBACK PAGE

// =========================

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController(text: studentName);

  final nimController = TextEditingController(text: studentId);

  final commentController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();

    nimController.dispose();

    commentController.dispose();

    super.dispose();
  }

  void submitFeedback() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text('Feedback Terkirim'),

          content: const Text('Terima kasih, feedback berhasil dikirim.'),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text('OK'),
            ),
          ],
        );
      },
    );

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Feedback berhasil disimpan')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Feedback')),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: Column(
            children: [
              TextFormField(
                controller: nameController,

                decoration: const InputDecoration(
                  labelText: 'Nama',

                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama wajib diisi';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: nimController,

                decoration: const InputDecoration(
                  labelText: 'NIM',

                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'NIM wajib diisi';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: commentController,

                maxLines: 5,

                decoration: const InputDecoration(
                  labelText: 'Komentar',

                  hintText: 'Tulis feedback minimal 5 karakter',

                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null || value.trim().length < 5) {
                    return 'Komentar minimal 5 karakter';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  onPressed: isLoading ? null : submitFeedback,

                  child: isLoading
                      ? const SizedBox(
                          height: 22,

                          width: 22,

                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Kirim Feedback'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FavoriteCounter extends StatefulWidget {
  const FavoriteCounter({super.key});

  @override
  State<FavoriteCounter> createState() => _FavoriteCounterState();
}

class _FavoriteCounterState extends State<FavoriteCounter> {
  final ValueNotifier<int> counter = ValueNotifier<int>(0);

  @override
  void dispose() {
    counter.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            const Text('Eksperimen ValueNotifier'),

            const SizedBox(height: 8),

            ValueListenableBuilder<int>(
              valueListenable: counter,

              builder: (context, value, child) {
                return Text(
                  'Jumlah favorit: $value',

                  style: const TextStyle(
                    fontSize: 20,

                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),

            const SizedBox(height: 8),

            ElevatedButton(
              onPressed: () {
                counter.value++;
              },

              child: const Text('Tambah Favorit'),
            ),
          ],
        ),
      ),
    );
  }
}
