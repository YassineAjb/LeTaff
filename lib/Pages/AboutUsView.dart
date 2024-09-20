import 'dart:ui' as ui;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:letaff/providers/NavBarProvider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AboutUsView extends StatefulWidget {
  
  @override
  _AboutUsViewState createState() => _AboutUsViewState();
}

class _AboutUsViewState extends State<AboutUsView> {
  late VideoPlayerController _controller;
  final firebase_storage.FirebaseStorage _storage = firebase_storage.FirebaseStorage.instance;
  String? _videoUrl;

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> statsData = [];

  Map<String, String?> imageUrls = {}; // Map to store URLs

  @override
  void initState() {
    super.initState();
    _fetchImages(); // Fetch all image URLs when the screen is initialized
    _fetchStats(); // Fetch data when the screen is initialized
    _fetchVideoUrl(); // Fetch video URL when the screen is initialized
  }

  Future<void> _fetchImages() async {
    // List of image paths and their keys
    final images = {
      'logo': 'images/le-taff-logo-1.png',
      'A-U-1': 'images/A-U-1.jpg',
      'A-U-2': 'images/A-U-2.jpg',
      'A-U-3': 'images/A-U-3.jpg',
      'A-U-4': 'images/A-U-4.jpg',
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

bool _isVideoLoaded = false;
Future<void> _fetchVideoUrl() async {
  try {
    String videoUrl = await _storage.ref('images/video.mp4').getDownloadURL();
    
    if (videoUrl.isNotEmpty) {
      _controller = VideoPlayerController.network(videoUrl)
        ..initialize().then((_) {
          setState(() {
            _isVideoLoaded = true; // Mark video as loaded
            _controller.play();
            _controller.setLooping(true);
          });
        });
    }
    print("Video URL: $videoUrl");
  } catch (e) {
    print("Error fetching video: $e");
    setState(() {
      _isVideoLoaded = false; // Handle the failure by showing an error message
    });
  }
}

  Future<void> _fetchStats() async {
    try {
      // Fetch data from Firestore
      QuerySnapshot snapshot = await _firestore.collection('stats').get();
      setState(() {
        statsData = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      });
    } catch (e) {
      print("Error fetching Stats: $e");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
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
                                //Image.asset('assets/le-taff-logo-1.png'),
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                    indent: 30,
                    endIndent: 30,
                  ),
                ],
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      "Nous sommes­ une­ agence­ de­ développement­ à­ service­ complet,­ dédiée­ à­ vous­ offrir­ les­ meilleurs­résultats.",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 30.0,
                        height: 1.2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),


                    Container(
                      //color: Colors.white, // Set the background color here
                      padding: const EdgeInsets.all(16.0),
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
                      child: Center(
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            //width: 250,
                            padding: const EdgeInsets.all(16.0),
                            
                            child: const Text(
                              "Notre agence de développement multinationale spécialisée dans la conception sur mesure de solutions web et d'applications mobiles adaptées à tous types de projets.",
                              //textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.fromARGB(255, 180, 180, 180),
                                fontSize: 19.0,
                                height: 1.5,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 300,
                            height: 60, 
                            child: ElevatedButton(
                              onPressed: () {
                                Provider.of<NavBarProvider>(context, listen: false).updateIndex(2); 
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
                                      "Visitez Notre Portfolio",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.deepOrange,
                                        fontSize: 18,
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
                        ],
                      ),
                    ),   
                  ),  
                  const SizedBox(height: 50),

                  
                  _isVideoLoaded
                        ? AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          )
                        : Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min, // Center the content vertically
                              children: [
                                const CircularProgressIndicator(color: Colors.deepOrange),
                                const SizedBox(height: 10),
                                Center(
                                  child: const Text(
                                    "Loading video...",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: ui.Color.fromARGB(255, 144, 144, 144),
                                      fontSize: 18,
                                    ),
                                  )
                                  .animate(onPlay: (controller) => controller.repeat()) // Smooth repeat
                                  ..shimmer(duration: 2000.ms, color: const ui.Color.fromARGB(255, 0, 0, 0)),
                                ),
                              ],
                            ),
                          ),


                  const SizedBox(height: 50),

                  const Text(     
                      "Agence De Développement",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),                  
                    const SizedBox(height: 10),
                    const Text(     
                      "Notre Mission",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    const SizedBox(
                      //height: 400,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 360,
                              height: 400,
                              child: Text(
                                "Notre approche distinctive repose sur la création de solutions de conception sur mesure, méticuleusement élaborées par notre équipe d'experts chevronnés. Chaque projet que nous entreprenons est façonné avec précision pour répondre de manière optimale aux besoins spécifiques de nos clients. Nous croyons fermement en l'importance d'un service client personnalisé, un service qui va au-delà de la simple satisfaction. Il guide chaque étape du processus, du concept initial à la réalisation finale, pour s'assurer que chaque détail est pris en compte.",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 142, 142, 142),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(width: 13), 
                            SizedBox(
                              width: 360,height: 400,
                              child: Text(
                              "Grâce à cette approche intégrale et à notre engagement constant envers l'excellence, nous sommes en mesure de fournir des solutions uniques et hautement performantes. Nos réalisations dépassent souvent les attentes, car nous visons non seulement à satisfaire nos clients, mais aussi à les impressionner. Avec notre expertise et notre dévouement, nous sommes fiers de contribuer au succès de chaque projet que nous entreprenons.",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 142, 142, 142),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 450,
                      width: 400,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            left: 0,
                             child: imageUrls['A-U-1'] != null
                              ? CachedNetworkImage(
                                  imageUrl: imageUrls['A-U-1']!, 
                                  placeholder: (context, url) => const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                  height: 200,     
                                  width: 180,      
                                  fit: BoxFit.cover,
                                )
                              : const CircularProgressIndicator()
                              .animate(onPlay: (controller) => controller.repeat(reverse: true)) // Smooth repeat
                              //.shimmer(duration: 3000.ms)
                              .boxShadow(duration: 1000.ms,
                            // Image.asset(
                            //   "assets/A-U-1.jpg",
                            //   height: 200,
                            //   width: 180,
                            //   fit: BoxFit.cover,
                            // )
                            //   .animate(onPlay: (controller) => controller.repeat(reverse: true)) // Smooth repeat
                            //   //.shimmer(duration: 3000.ms)
                            //   .boxShadow(duration: 1000.ms,
                                  begin: const BoxShadow(
                                    blurRadius: 4,
                                    color: ui.Color.fromARGB(255, 255, 255, 255),
                                    spreadRadius: 1,
                                  ),
                                  end: const BoxShadow(
                                    blurRadius: 4,
                                    color: ui.Color.fromARGB(255, 255, 255, 255),
                                    spreadRadius: 3,
                                  ),
                                  curve: Curves.easeInOut,
                                ), 
                          ),
                          Positioned(
                            top: 0,
                            left: 190,
                            child: imageUrls['A-U-2'] != null
                              ? CachedNetworkImage(
                                  imageUrl: imageUrls['A-U-2']!, 
                                  placeholder: (context, url) => const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                  height: 200,     
                                  width: 180,      
                                  fit: BoxFit.cover,
                                )
                              : const CircularProgressIndicator()
                              .animate(onPlay: (controller) => controller.repeat(reverse: true)) // Smooth repeat
                              //.shimmer(duration: 3000.ms)
                              .boxShadow(duration: 1000.ms,
                            // Image.asset(
                            //   "assets/A-U-2.jpg",
                            //   height: 200,
                            //   width: 180,
                            //   fit: BoxFit.cover,
                            // )
                            //   .animate(onPlay: (controller) => controller.repeat(reverse: true)) // Smooth repeat
                            //   //.shimmer(duration: 7000.ms)
                            //   .boxShadow(duration: 1100.ms,
                                  begin: const BoxShadow(
                                    blurRadius: 4,
                                    color: ui.Color.fromARGB(255, 255, 255, 255),
                                    spreadRadius: 1,
                                  ),
                                  end: const BoxShadow(
                                    blurRadius: 4,
                                    color: ui.Color.fromARGB(255, 255, 255, 255),
                                    spreadRadius: 3,
                                  ),
                                  curve: Curves.easeInOut,
                                ),
                          ),
                          Positioned(
                            top: 220,
                            left: 0,
                            child: imageUrls['A-U-3'] != null
                              ? CachedNetworkImage(
                                  imageUrl: imageUrls['A-U-3']!, 
                                  placeholder: (context, url) => const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                  height: 200,     
                                  width: 180,      
                                  fit: BoxFit.cover,
                                )
                              : const CircularProgressIndicator()
                              .animate(onPlay: (controller) => controller.repeat(reverse: true)) // Smooth repeat
                              //.shimmer(duration: 3000.ms)
                              .boxShadow(duration: 1000.ms,
                            // Image.asset(
                            //   "assets/A-U-3.jpg",
                            //   height: 200,
                            //   width: 180,
                            //   fit: BoxFit.cover,
                            // )
                              // .animate(onPlay: (controller) => controller.repeat(reverse: true)) // Smooth repeat
                              // //.shimmer(duration: 7000.ms)
                              // .boxShadow(duration: 1200.ms,
                                  begin: const BoxShadow(
                                    blurRadius: 4,
                                    color: ui.Color.fromARGB(255, 255, 255, 255),
                                    spreadRadius: 1,
                                  ),
                                  end: const BoxShadow(
                                    blurRadius: 4,
                                    color: ui.Color.fromARGB(255, 255, 255, 255),
                                    spreadRadius: 3,
                                  ),
                                  curve: Curves.easeInOut,
                                ),
                          ),
                          Positioned(
                            top: 220,
                            left: 190,
                            child: 
                            imageUrls['A-U-4'] != null
                              ? CachedNetworkImage(
                                  imageUrl: imageUrls['A-U-4']!, 
                                  placeholder: (context, url) => const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                  height: 200,     
                                  width: 180,      
                                  fit: BoxFit.cover,
                                )
                              : const CircularProgressIndicator()
                              .animate(onPlay: (controller) => controller.repeat(reverse: true)) // Smooth repeat
                              //.shimmer(duration: 3000.ms)
                              .boxShadow(duration: 1000.ms,
                            //   Image.asset(
                            //   "assets/A-U-4.jpg",
                            //   height: 200,
                            //   width: 180,
                            //   fit: BoxFit.cover,
                            // )
                            //   .animate(onPlay: (controller) => controller.repeat(reverse: true)) // Smooth repeat
                            //   //.shimmer(duration: 7000.ms)
                            //   .boxShadow(duration: 1300.ms,
                                  begin: const BoxShadow(
                                    blurRadius: 4,
                                    color: ui.Color.fromARGB(255, 255, 255, 255),
                                    spreadRadius: 1,
                                  ),
                                  end: const BoxShadow(
                                    blurRadius: 4,
                                    color: ui.Color.fromARGB(255, 255, 255, 255),
                                    spreadRadius: 3,
                                  ),
                                  curve: Curves.easeInOut,
                                ),
                                    //.scaleXY(end: 1.001, curve: Curves.easeOutCirc),
                          ),
                        ],
                      ),
                    ),

                    //const SizedBox(height: 40,),

Table(
  // Optionally, set a border for the table
  columnWidths: const {
    0: FlexColumnWidth(1),
    1: FlexColumnWidth(1),
  },
  children: [
    for (int i = 0; i < statsData.length; i += 2)
      TableRow(
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            child: AnimatedNumberWidget(
              endValue: statsData[i]["value"],
              label: statsData[i]["label"],
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            child: AnimatedNumberWidget(
              endValue: statsData[i + 1]["value"],
              label: statsData[i + 1]["label"],
            ),
          ),
        ],
      ),
  ],
),


                    const SizedBox(height: 50,),

                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          //color: Colors.grey[800],
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
                            color: Colors.white, // Set the border color
                            width: 1.5, // Set the border width
                          ),
                        ),
                        child: const Text(
                          'TRAVAILLEZ AVEC NOUS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          //color: Colors.grey[800],
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
                          "Nous serions ravis d'en savoir davantage sur votre projet",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromARGB(255, 185, 185, 185),
                            fontSize: 27.0,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: 120, // Adjust to the desired diameter
                        height: 120, // Must match the width to make it a circle
                        child: ElevatedButton(
                          onPressed: () {
                            Provider.of<NavBarProvider>(context, listen: false).updateIndex(4); 
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(90), // Half of width/height for a circle
                           side: const BorderSide(
                              color: Color.fromARGB(255, 115, 115, 115), // Border color
                              width: 2.5, // Border width
                            ),
                            ),
                            padding: EdgeInsets.zero, // Remove padding to ensure circular shape
                          ),
                          child: const Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Contactez\nNous",textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontSize: 19,
                                  ),
                                ),
                                SizedBox(width: 2), // Add some spacing between text and icon
                                Icon(
                                  Icons.moving,
                                  color: Colors.deepOrange,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                      .shimmer(duration: 4000.ms),
                    ),

        
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

class AnimatedNumberWidget extends StatefulWidget {
  final int endValue;
  final String label;

  const AnimatedNumberWidget({
    super.key,
    required this.endValue,
    required this.label,
  });

  @override
  _AnimatedNumberWidgetState createState() => _AnimatedNumberWidgetState();
}

class _AnimatedNumberWidgetState extends State<AnimatedNumberWidget> {
  late int _currentValue;

  @override
void initState() {
  super.initState();
  // Initialize _currentValue in initState
  _currentValue = (widget.endValue - 10).clamp(0, double.infinity).toInt();
}

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.label),
      onVisibilityChanged: (VisibilityInfo info) {
        if (info.visibleFraction > 0.5) {
          // Start the animation when the widget is visible
          setState(() {
            _currentValue = widget.endValue;
          });
        } else if (info.visibleFraction == 0) {
          // Reset the number when the widget is no longer visible
          setState(() {
            _currentValue = (widget.endValue - 10).clamp(0, double.infinity).toInt();
          });
        }
      },
      // child: TweenAnimationBuilder<int>(
      //   tween: IntTween(begin: widget.endValue - 10, end: _currentValue),
        child: TweenAnimationBuilder<int>(
        tween: IntTween(
          begin: (widget.endValue - 10).clamp(0, double.infinity).toInt(),
          end: _currentValue
        ),
        duration: const Duration(seconds: 1),
        builder: (context, value, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "$value+",
                style: const TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(255, 168, 168, 168),
                ),
              ).animate(onPlay: (controller) => controller.repeat())
                .shimmer(duration: 3000.ms, color: Colors.deepOrange),
              Text(
                widget.label,
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}