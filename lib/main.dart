import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'course_state.dart';

import 'models/course.dart';



const String studentName = 'Made Gatan Pytrhsno Penar';

const String studentId = '2415051118';



void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CourseState(),
      child: const MyApp(),
    ),
  );
}


// DATA COURSE

// =========================



final List<Map<String, dynamic>> courses = [

  {

    'code': 'MOB01',

    'title': 'Git & GitHub',

    'credits': 2,

    'status': 'Selesai',

    'description':

        'Mempelajari dasar penggunaan Git dan GitHub untuk mengelola project.',

  },

  {

    'code': 'MOB02',

    'title': 'Dart Fundamentals',

    'credits': 2,

    'status': 'Selesai',

    'description': 'Mempelajari dasar bahasa pemrograman Dart yang digunakan pada Flutter.',

  },

  {

    'code': 'MOB03',

    'title': 'Flutter UI Fundamentals',

    'credits': 3,

    'status': 'Aktif',

    'description':

        'Mempelajari pembuatan tampilan aplikasi menggunakan widget Flutter.',

  },

  {

    'code': 'MOB04',

    'title': 'Responsive Layout',

    'credits': 2,

    'status': 'Aktif',

    'description': 'Mempelajari cara membuat tampilan Flutter yang menyesuaikan ukuran layar.',

  },

  {

    'code': 'MOB05',

    'title': 'Navigation & Interaction',

    'credits': 3,

    'status': 'Belum',

    'description': 'Mempelajari navigasi antar halaman dan interaksi pengguna pada Flutter.',

  },

];



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



  final List<Widget> pages = const [HomePage(), CoursesPage(), ProfilePage()];



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

    final courseState = context.watch<CourseState>();
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

                            children: const [

                              Text(

                                'Status',

                                style: TextStyle(fontWeight: FontWeight.bold),

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

                    isFavorite: courseState.favorites.contains(course['code']),
                    onFavorite: () {
                      context.read<CourseState>().toggleFavorite(course['code'] as String);
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
    final courseState = context.watch<CourseState>();

    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Course')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          int columnCount;
          if (constraints.maxWidth < 600) {
            columnCount = 1;
          } else if (constraints.maxWidth < 840) {
            columnCount = 2;
          } else {
            columnCount = 3;
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: courses.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columnCount,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: constraints.maxWidth < 600 ? 1.5 : 1.2,
            ),
            itemBuilder: (context, index) {
              final course = courses[index];
              final code = course['code'] as String;

              return CourseCard(
                course: course,
                isFavorite: courseState.favorites.contains(code),
                onFavorite: () {
                  context.read<CourseState>().toggleFavorite(code);
                  final isFavorite = context.read<CourseState>().favorites.contains(code);
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
                      builder: (context) => CourseDetailPage(course: course),
                    ),
                  );
                },
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(course['title']),
                      content: Text(
                        'Kode: ${course['code']}\n'
                        'SKS: ${course['credits']}\n'
                        'Status: ${course['status']}',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Tutup'),
                        ),
                      ],
                    ),
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

                      course['title'],

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



              Text('${course['code']} • ${course['credits']} SKS'),



              const SizedBox(height: 8),



              Text(

                course['status'],

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

                    isExpanded ? 'Sembunyikan detail' : 'Lihat deskripsi',

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
              final nowFavorite = context.read<CourseState>().favorites.contains(code);
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
