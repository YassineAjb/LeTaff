import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:letaff/Pages/ContactView.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cached_network_image/cached_network_image.dart';

class PortfolioView extends StatefulWidget {
  const PortfolioView({super.key});

  @override
  _PortfolioViewState createState() => _PortfolioViewState();
}

class _PortfolioViewState extends State<PortfolioView> {
  
  final firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;
  String? logoUrl;

  final ScrollController _scrollController = ScrollController();
  Timer? _scrollTimer;

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> projectData = [];

  Map<String, String?> imageUrls = {}; // Map to store URLs

  @override
  void initState() {
    super.initState();
    _fetchImages();
    _fetchProjects(); // Fetch data when the screen is initialized
    print("-------------------------------------------------");
    print(projectData);
    print("-------------------------------------------------");
    
        // Trigger the animations when the page is opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        // This rebuilds the widget to start the animations
      });
    });
    _startAutoScroll();
  }

  Future<void> _fetchImages() async {
    // List of image paths and their keys
    final images = {
      'logo': 'images/le-taff-logo-1.png',
      //'log': 'images/abqsj-770x852.jpg',
      
    };

    // Fetch URLs for all images
    final futures = images.entries.map((entry) async {
      final url = await fetchImageUrl(entry.value);
      imageUrls[entry.key] = url;
    });

    // Wait for all images to be fetched
    await Future.wait(futures);
    print(imageUrls);

    // Trigger a rebuild to reflect changes
    setState(() {});
  }
  Future<String?> fetchImageUrl(String refPath) async {
    try {
      String url = await _storage.ref(refPath).getDownloadURL();
      return url;
    } catch (e) {
      print("Error fetching image: $e");
      return null;
    }
  }

  // Future<void> _fetchProjects() async {
  //   try {
  //     // Fetch data from Firestore
  //     QuerySnapshot snapshot = await _firestore.collection('projects').get();
  //     setState(() {
  //       projectData = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  //     });
  //   } catch (e) {
  //     print("Error fetching projects: $e");
  //   }
  // }
Future<void> _fetchProjects() async {
  try {
    // Fetch data from Firestore
    QuerySnapshot snapshot = await _firestore.collection('projects').get();

    // Fetch image URLs for each project
    List<Map<String, dynamic>> updatedProjectData = await Future.wait(
      snapshot.docs.map((doc) async {
        Map<String, dynamic> project = doc.data() as Map<String, dynamic>;
        
        // Fetch the image URL using Firebase Storage
        String? imageUrl = await fetchImageUrl(project['image']); // Assuming 'image' stores the path
        project['imageUrl'] = imageUrl; // Add the image URL to the project data
        
        return project;
      }).toList(),
    );

    // Update the state
    setState(() {
      projectData = updatedProjectData;
    });
  } catch (e) {
    print("Error fetching projects: $e");
  }
}

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

void _startAutoScroll() {
    _scrollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_scrollController.hasClients) {
        final double maxScrollExtent = _scrollController.position.maxScrollExtent;
        final double currentScrollPosition = _scrollController.position.pixels;

        if (currentScrollPosition < maxScrollExtent) {
          _scrollController.animateTo(
            currentScrollPosition + 380, // Adjust this value as needed
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        } else {
          _scrollController.animateTo(
            0,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }


  @override
  void dispose() {
    _scrollTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: projectData.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(child: SizedBox(height: 20)),
                  SliverToBoxAdapter(
                    child: Container(
                      height: 100,
                      color: Colors.black,
                      child: Center(
                        child: 
                          imageUrls['logo'] != null
                            ? CachedNetworkImage(
                                imageUrl: imageUrls['logo']!,
                                placeholder: (context, url) => const CircularProgressIndicator(),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              )
                            : const CircularProgressIndicator(),
                        // Image.asset('assets/le-taff-logo-1.png'),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 30,
                      endIndent: 30,
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 20)),
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "PORTFOLIO DE",
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 30.0,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Réalisations",
                            style: TextStyle(
                              color: Color.fromARGB(255, 120, 120, 120),
                              fontSize: 69.0,
                              height: 0.9,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Découvrez notre portfolio de réalisations, une collection visuelle de nos sites web et applications exceptionnels. Explorez nos réalisations pour voir comment nous transformons les idées en expériences numériques de premier ordre.",
                            style: TextStyle(
                              color: Color.fromARGB(255, 221, 221, 221),
                              fontSize: 19.0,
                              height: 1.5,
                            ),
                          ),
                          SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      height: 340, // Set a fixed height for the project section
                      child: ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: projectData.length,
                        itemBuilder: (context, index) {
                          final project = projectData[index];
                          return VisibilityDetector(
                            key: Key(project['title']),
                            onVisibilityChanged: (info) {
                              if (info.visibleFraction > 0 && !project['isVisible']) {
                                setState(() {
                                  project['isVisible'] = true;
                                });
                              }
                            },
                            child: Container(
                              width: 380,
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
                                    // Image.asset(
                                    //   project['image'],
                                    //   width: 380,
                                    //   height: 340,
                                    //   fit: BoxFit.cover,
                                    // ),
                                    ///////////////////////////
                                    CachedNetworkImage(
                                      imageUrl: project['image'], // Cached image
                                      width: 380,
                                      height: 340,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => CircularProgressIndicator(),
                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                    ),
                                    /////////////////////////////
                                    CachedNetworkImage(
                                      imageUrl: project['imageUrl'] ?? '', // Use the fetched imageUrl
                                      width: 380,
                                      height: 340,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => CircularProgressIndicator(),
                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                    ),

                                    Container(
                                      width: 380,
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
                                          ? Container(
                                              padding: const EdgeInsets.all(8.0),
                                              decoration: BoxDecoration(
                                                color: Colors.black.withOpacity(0.4),
                                                borderRadius: BorderRadius.circular(12.0),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    project['title'],
                                                    style: const TextStyle(
                                                      color: Colors.deepOrange,
                                                      fontSize: 24.0,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ).animate().fade(duration: 1000.ms).scale(delay: 1000.ms),
                                                  const SizedBox(height: 8.0),
                                                  Text(
                                                    project['date'],
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Container(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 40)),
                  SliverToBoxAdapter(
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          border: Border.all(
                            color: Colors.white,
                            width: 1.5,
                          ),
                        ),
                        child: const Text(
                          'TRAVAILLONS ENSEMBLE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Text(
                          'Nous aimerions en savoir\nplus sur votre projet',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromARGB(255, 185, 185, 185),
                            fontSize: 27.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Center(
                      child: SizedBox(
                        width: 120,
                        height: 120,
                        child: ElevatedButton(
                          // onPressed: () {
                          //   Navigator.pushNamed(context, '/solutionweb');
                          //   print('Navigating to ContactView...');
                          // },
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>  ContactView(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(90),
                              side: const BorderSide(
                                color: Color.fromARGB(255, 115, 115, 115),
                                width: 2.5,
                              ),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          child: const Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Parlons\nNous",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontSize: 19,
                                  ),
                                ),
                                SizedBox(width: 2),
                                Icon(
                                  Icons.moving,
                                  color: Colors.deepOrange,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 50)),
                  
                  const SliverToBoxAdapter(
                    child: Divider(
                    color: Colors.grey,
                    thickness: 1,
                    indent: 30,
                    endIndent: 30,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Image.asset('asset/linked4.png', width: 45, height: 45),
                            onPressed: () => _launchURL('https://www.linkedin.com'),
                          ),
                          const SizedBox(width: 0),
                          IconButton(
                            icon: Image.asset('asset/beIcon.png', width: 45, height: 45),
                            onPressed: () => _launchURL('https://www.linkedin.com'),
                          ),
                          const SizedBox(width: 0),
                          IconButton(
                            icon: Image.asset('asset/insta4.png', width: 45, height: 45),
                            onPressed: () => _launchURL('https://www.instagram.com'),
                          ),
                          const SizedBox(width: 0),
                          IconButton(
                            icon: Image.asset('asset/face5.png', width: 45, height: 45),
                            onPressed: () => _launchURL('https://www.facebook.com'),
                          ),
                          IconButton(
                            icon: Image.asset('asset/tiktokicon.png', width: 45, height: 45),
                            onPressed: () => _launchURL('https://www.instagram.com'),
                          ),
                          const SizedBox(width: 0),
                        ],
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 50)),
                ],
              ),
      ),
    );
  }
}
