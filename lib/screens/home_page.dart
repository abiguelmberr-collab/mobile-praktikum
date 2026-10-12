
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../course_state.dart';
import '../models/course.dart';
import '../constants/student_info.dart';
import '../widgets/course_card.dart';
import 'course_detail_page.dart';
import '../data/courses.dart';



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