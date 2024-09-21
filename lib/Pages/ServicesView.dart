import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:letaff/providers/NavBarProvider.dart';
import 'package:letaff/Pages/SolutionMaintView.dart';
import 'package:letaff/Pages/SolutionMarketingView.dart';
import 'package:letaff/Pages/SolutionMobileView.dart';
import 'package:letaff/Pages/SolutionWebView.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ServicesView extends StatefulWidget {
  @override
  _ServicesViewState createState() => _ServicesViewState();
}

class _ServicesViewState extends State<ServicesView> {

  final firebase_storage.FirebaseStorage _storage = firebase_storage.FirebaseStorage.instance;
  Map<String, String?> imageUrls = {}; // Map to store URLs
  Map<String, String?> ServiceImageUrls = {}; // Map to store URLs

  final ScrollController _scrollController = ScrollController();
  Timer? _scrollTimer;
  final ScrollController _textScrollController = ScrollController();
  Timer? _textScrollTimer;

  @override
  void initState() {
    super.initState();
    _fetchImages();
    // Trigger the animations when the page is opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        // This rebuilds the widget to start the animations
      });
    });
    _startAutoScroll();
    _startTextAutoScroll();

  }

    // List of image paths
    final List<String> imagePaths = [
      'images/creative1Logo.png',
      'images/creative2Logo.png',
      'images/innovateLogo.png',
      'images/EXPRESSLogo.png',
      'images/BRANDNAMELogo.png',
      'images/NAMELogo.png',
    ];

  Future<void> _fetchImages() async {    

    for (int i = 0; i < imagePaths.length; i++) {
    String refPath = imagePaths[i]; // Firebase Storage path
    String? url = await fetchImageUrl(refPath);
    imagePaths[i] = url ?? 'default_image_url'; // Store fetched URL or use a default
  }
    // List of image paths and their keys
    final images = {
      'logo':  'images/le-taff-logo-1.png',
    };
// List of image paths and their keys
    final Simages = {
      '0': 'images/Sweb.jpg',
      '1': 'images/SMobile.png',
      '2': 'images/SDigital.png',
      '3': 'images/Smaintenance.jpg',
    };
    // Fetch URLs for all images
    final futures = images.entries.map((entry) async {
      final url = await fetchImageUrl(entry.value);
      imageUrls[entry.key] = url;
    });
    // Fetch URLs for all Simages
    final Sfutures = Simages.entries.map((entry) async {
      final url = await fetchImageUrl(entry.value);
      ServiceImageUrls[entry.key] = url;
    });

    // Wait for all images to be fetched
    await Future.wait(futures);
    await Future.wait(Sfutures);
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


Future<void> _launchURL(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
}

  @override
  void dispose() {
    _scrollTimer?.cancel();
    _textScrollTimer?.cancel();
    _scrollController.dispose();
    _textScrollController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _scrollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_scrollController.hasClients) {
        final double maxScrollExtent = _scrollController.position.maxScrollExtent;
        final double currentScrollPosition = _scrollController.position.pixels;

        if (currentScrollPosition < maxScrollExtent) {
          _scrollController.animateTo(
            currentScrollPosition + 350, // Adjust this value as needed
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

void _startTextAutoScroll() {
  _textScrollTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
    if (_textScrollController.hasClients) {
      final double maxScrollExtent = _textScrollController.position.maxScrollExtent;
      final double currentScrollPosition = _textScrollController.position.pixels;

      // Increase scroll increment for smoother scrolling
      const double scrollIncrement = 4.0;

      if (currentScrollPosition < maxScrollExtent) {
        _textScrollController.animateTo(
          currentScrollPosition + scrollIncrement,
          duration: const Duration(milliseconds: 100),
          curve: Curves.linear,
        );
      } else {
        // Smoothly scroll back to the start
        _textScrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.linear,
        );
      }
    }
  });
}


  @override
  Widget build(BuildContext context) {
    
    // Data for services containers
    final List<Map<String, dynamic>> servicesData = [
      {
        'title': 'SOLUTIONS WEB',
        'description': 'Nous mettons à votre disposition notre expertise pour répondre de manière globale à vos besoins en ligne.',
        'buttonText': 'Savoir plus',
        'buttonAction': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SolutionWebView()),
          );
          print("Details for Service SOLUTIONS WEB");
        },
        'index': '0',
      },
      {
        'title': 'APPLICATIONS MOBILE',
        'description': "Nous mettons à votre disposition notre expertise en développement d'applications mobiles pour répondre de manière globale à vos besoins du création des applications personnalisées .",
        'buttonText': 'Savoir plus',
        'buttonAction': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SolutionMobileView()),
          );
          print("Details for Service DÉVELOPPEMENT MOBILE");
        },
        'index': '1',
      },
      {
        'title': 'MARKETING DIGITAL',
        'description': 'Nous élaborons des stratégies ciblées et innovantes pour renforcer votre visibilité en ligne et assurer la croissance de votre entreprise',
        'buttonText': 'Savoir plus',
        'buttonAction': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SolutionMarketingView()),
          );
          print("Details for Service MARKETING DIGITAL");
        },
        'index': '2',
      },
      {
        'title': 'Maintenance',
        'description': 'Nous offrons une assistance technique pour résoudre les problèmes rapidement et efficacement',
        'buttonText': 'Savoir plus',
        'buttonAction': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SolutionMaintView()),
          );          
          print("Details for Service Maintenance");
        },
        'index': '3',
      },
    ];

        // New data list for scrolling texts
    final List<String> scrollingTexts = [
      '        ',
      'SOLUTIONS WEB',
      'DEV MOBILE',
      'MARKETING',
      'MAINTENANCE',
      'SOLUTIONS WEB',
    ];

Widget buildScrollingTexts() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _textScrollController,
        child: Row(
          children: scrollingTexts.map((text) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 4, 0, 63),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      );
    }
Widget buildServiceDescriptions() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: servicesData.map((service) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              service['title'],
              style:const TextStyle(
                //color: const Color.fromARGB(255, 255, 255, 255),
                color:Color.fromARGB(255, 255, 255, 255),
                fontSize: 20.0,
              ),
            ).animate(onPlay: (controller) => controller.repeat())
                .shimmer(duration: 4000.ms, color: Colors.deepOrange),
            const SizedBox(height: 8.0), // Add some space between title and description
            Text(
              service['description'],
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 16.0,
              ),
            ).animate(onPlay: (controller) => controller.repeat())
                .shimmer(duration: 4000.ms, color: const Color.fromARGB(255, 255, 255, 255)),
          ],
        ),
      );
    }).toList(),
  );
}

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
                              placeholder: (context, url) => buildCircularIndicatorWithImage(),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            )
                          : buildCircularIndicatorWithImage(),
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 0, 0, 0),
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
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Services De",
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Développement Digital",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 33,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Nos services de développement digital englobent une gamme complète de solutions web, des applications mobiles innovantes, des stratégies SEO avancées, du marketing digital percutant, des créations graphiques originales, ainsi que des services de Développement et Marketing.",
                            style: TextStyle(
                              color: Color.fromARGB(255, 152, 152, 152),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    hr,

                    // Display list of services descriptions
                    buildServiceDescriptions(),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: _scrollController,
                      child: Row(
                        children: servicesData.map((service) {
                          return Container(
                            width: 340,
                            height: 370,
                            padding: const EdgeInsets.all(16.0),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    service['title'],
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 216, 216, 216),
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                
                                Container(
                                  width: 340,
                                  height: 210,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0), // To apply border radius to the image
                                    child: CachedNetworkImage(
                                      imageUrl: ServiceImageUrls[service['index']] ?? '', // Replace 'logo' with the desired key
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Center(
                                        child: buildCircularIndicatorWithImage(), // Display while loading
                                      ),
                                      errorWidget: (context, url, error) => const Icon(Icons.error,color :Colors.deepOrange), // Display in case of error
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: service['buttonAction'],
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(90), 
                                            side: const BorderSide(
                                              color: Color.fromARGB(255, 115, 115, 115), 
                                              width: 1.5, 
                                            ),
                                          ),
                                          // padding: EdgeInsets.zero, 
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              service['buttonText'],
                                              style: const TextStyle(
                                                color: Colors.deepOrange,
                                              ),
                                            ),
                                            const SizedBox(width: 5.0),
                                            const Icon(
                                              Icons.moving,
                                              color: Colors.deepOrange,
                                              size: 30,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 40),

                    const Text(
                      "Transformation Numérique Intégrale : Nos Services de Développement Digital",
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    )        .animate(onPlay: (controller) => controller.repeat())
                              // .fadeIn(duration: 900.ms, delay: 300.ms)
                              .shimmer(duration: 9000.ms,blendMode: BlendMode.srcOver, color: Colors.white12),
                              // .move(begin: const Offset(-16, 0), curve: Curves.easeOutQuad),
                    const SizedBox(height: 20),

                    const SizedBox(
                      height: 350,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 360,
                              height: 400,
                              child: Text(
                                "Nos services de développement digital offrent une palette complète de solutions pour répondre à vos besoins en ligne. Cela englobe la conception et la création de sites web, le développement d’applications mobiles sur mesure, des stratégies SEO avancées visant à renforcer votre présence en ligne, une stratégie de marketing digital percutante, la création de graphismes originaux, ainsi que des services de développement et de marketing intégrés.",
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
                              "Notre équipe d’experts met à votre disposition son savoir-faire afin d’assurer la croissance de votre entreprise grâce à des solutions numériques novatrices. De plus, nous sommes là pour vous offrir une assistance technique rapide et efficace, résolvant rapidement les problèmes liés au développement digital. Avec nos services, vous pouvez atteindre vos objectifs en ligne de manière complète et hautement efficace, tout en restant à la pointe de la transformation numérique.",
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
                    
                    // New scrolling texts view
                    buildScrollingTexts(),
                    const SizedBox(height: 40),

                    const Text(
                      "Technologies",
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Explorez notre univers de technologies adaptéesau service du progrès",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Grid view of cards
                    GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          itemCount: imagePaths.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 4,
                              color: const Color.fromARGB(255, 16, 16, 16), // card color
                              // child: Image.asset(imagePaths[index], fit: BoxFit.cover),
                              child: imagePaths[index].isNotEmpty 
                              ? CachedNetworkImage(
                                  imageUrl: imagePaths[index],
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => buildCircularIndicatorWithImage(),
                                  errorWidget: (context, url, error) => const Icon(Icons.error,color :Colors.deepOrange),
                                )
                              : const Icon(Icons.broken_image,color :Colors.deepOrange), // Fallback if the image path is empty

                            );
                          },
                    ),
                    const SizedBox(height: 20),
                    // Horizontal line (Divider)
                    const Divider(
                      color: Colors.grey, // Color of the divider
                      thickness: 1, // Thickness of the divider
                      indent: 20, // Indentation from the start (leading edge)
                      endIndent: 20, // Indentation from the end (trailing edge)
                    ),
                    const SizedBox(height: 15),

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
                          'TRAVAILLONS ENSEMBLE',
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
                          'Nous aimerions en savoir\nplus sur votre projet',
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
                            Provider.of<NavBarProvider>(context, listen: false).updateIndex(4); // Navigate to Portfolio (index 2)
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
                                  "Parlons\nNous",textAlign: TextAlign.center,
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
                        ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                      .shimmer(duration: 4000.ms),
                      ),
                    ),

                    const SizedBox(height: 50),
                    // Social Media Buttons
                    Center(
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
                          
                          // PACKAGE PROBLEM !!!!!!!!!!
                          // IconButton(
                          //   icon: const Icon(Icons.facebook, color: Colors.deepOrange, size: 30,),
                          //   onPressed: () => _launchURL('https://www.facebook.com'),
                          // ),
                          // IconButton(
                          //   icon: Icon(FlutterSocialIcons.linkedin, color: Colors.blue),
                          //   onPressed: () => _launchURL('https://www.linkedin.com'),
                          // ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),










const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
          ],
                              
        ),
      ),
    );
  }

  Widget get hr => Container(
    height: 2,
    color: const Color(0x8080DDFF),
    margin: const EdgeInsets.symmetric(vertical: 16),
  ).animate().scale(duration: 600.ms, alignment: Alignment.centerLeft);
}

Widget buildCircularIndicatorWithImage() {
  return Stack(
    alignment: Alignment.center,
    children: [
      const SizedBox(
        width: 100.0,  // Set the desired size of the CircularProgressIndicator
        height: 100.0,
        child: CircularProgressIndicator(
          strokeWidth: 4.0,
          color: Colors.deepOrange,
        ),
      ),
      Positioned(
        child: Image.asset(
          'asset/logo-blanc.png',  // Replace with your image path
          width: 70.0,
          height: 70.0,
        ),
      ),
    ],
  );
}
