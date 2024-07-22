// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Flutter Animation Example'),
//         ),
//         body: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text("Hello").animate()
//                   .fade(duration: 500.ms)
//                   .scale(delay: 500.ms), // runs after fade
                
//                 Text("Hello World!").animate()
//                   .fadeIn() // uses `Animate.defaultDuration`
//                   .scale() // inherits duration from fadeIn
//                   .move(delay: 300.ms, duration: 600.ms) // runs after the above with new duration
//                   .blurXY(), // inherits the delay & duration from move
                
//                 Text("Hello").animate(
//                   delay: 1000.ms, // this delay only happens once at the very start
//                   onPlay: (controller) => controller.repeat(), // loop
//                 ).fadeIn(delay: 500.ms), // this delay happens at the start of each loop
                
//                 Text("Hello").animate().fade(), // begin=0, end=1
//                 Text("Hello").animate().fade(begin: 0.5), // end=1
//                 Text("Hello").animate().fade(end: 0.5), // begin=1
//                 Text('Hello').animate().tint(color: Colors.purple),
                
//                 Text("Hello").animate()
//                   .fadeIn(duration: 600.ms)
//                   .then(delay: 200.ms) // baseline=800ms
//                   .slide(),

//                 Column(
//                   children: [Text("Hello"), Text("World"), Text("Goodbye")]
//                     .animate(interval: 400.ms).fade(duration: 300.ms),
//                 ),
                
//                 Text("Hello World").animate().custom(
//                   duration: 300.ms,
//                   builder: (context, value, child) => Container(
//                     color: Color.lerp(Colors.red, Colors.blue, value),
//                     padding: EdgeInsets.all(8),
//                     child: child, // child is the Text widget being animated
//                   ),
//                 ),
                
//                 Animate().custom(
//                   duration: 10.seconds,
//                   begin: 10,
//                   end: 0,
//                   builder: (_, value, __) => Text(value.round().toString()),
//                 ).fadeOut(),
                
//                 Animate().toggle(
//                   duration: 2.seconds,
//                   builder: (_, value, __) => Text(value ? "Before" : "After"),
//                 ),
                
//                 Animate().toggle(
//                   duration: 1.ms,
//                   builder: (_, value, __) => AnimatedContainer(
//                     duration: 1.seconds,
//                     color: value ? Colors.red : Colors.green,
//                   ),
//                 ),
                
//                 Text("Before").animate()
//                   .swap(duration: 900.ms, builder: (_, __) => Text("After")),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:rive_animated_icon/rive_animated_icon.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}
class _HomeViewState extends State<HomeView> {
  List<Map<String, dynamic>> ProjectData = [
    {
      'title': 'ACADEMINY',
      'image': 'assets/hom2.png',
      'isVisible': false,
    },
    {
      'title': 'SAVONNERIE\nZEN',
      'image': 'assets/hom2.png',
      'isVisible': false,
    },
    {
      'title': 'ABSQJ',
      'image': 'assets/hom2.png',
      'isVisible': false,
    },
    {
      'title': 'CLINIQUE RADIOLOGIQUE',
      'image': 'assets/hom2.png',
      'isVisible': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ProjectData.map((project) {
                  return VisibilityDetector(
                    key: Key(project['title']),
                    onVisibilityChanged: (info) {
                      print('Visibility changed for ${project['title']}: ${info.visibleFraction}');
                      if (info.visibleFraction > 0.5) {
                        setState(() {
                          project['isVisible'] = true;
                        });
                      }
                    },
                    child: Container(
                      width: 340,
                      height: 340,
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 24, 24, 24),
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Stack(
                          children: [
                            Image.asset(
                              project['image'],
                              width: 340,
                              height: 340,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              width: 340,
                              height: 340,
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.black.withOpacity(0.1),
                                    Colors.black.withOpacity(0.6),
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 16.0,
                              left: 16.0,
                              child: project['isVisible']
                                  ? AnimatedOpacity(
                                      opacity: project['isVisible'] ? 1.0 : 0.0,
                                      duration: Duration(milliseconds: 1000),
                                      child: Text(
                                        project['title'],
                                        style: const TextStyle(
                                          color: Colors.deepOrange,
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ),
      ),
    );
  }
}
