import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:video_player/video_player.dart';

class AboutUsView extends StatefulWidget {

  @override
  _AboutUsViewState createState() => _AboutUsViewState();
}

class _AboutUsViewState extends State<AboutUsView> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
      });
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
                      child: Image.asset('assets/le-taff-logo-1.png'),
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
                            /*decoration: BoxDecoration(
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
                            ),*/
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
                                Navigator.pushNamed(context, '/contact');
                                print('Navigating to ContactView...');
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

                  _controller.value.isInitialized
                  ? SizedBox(
                      height: 200,
                      child: VideoPlayer(_controller),
                    )
                  : const CircularProgressIndicator(),
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

                    // Image.asset("assets/A-U-1.jpg")
                    //   .animate(onPlay: (controller) => controller.repeat()) // Repeat animation indefinitely
                    //   .shimmer(duration: 3000.ms), // Apply shimmer effect
                    // Image.asset("assets/A-U-2.jpg")
                    //   .animate(onPlay: (controller) => controller.repeat()) // Repeat animation indefinitely
                    //   .shimmer(duration: 3000.ms), // Apply shimmer effect
                    // Image.asset("assets/A-U-3.jpg")
                    //   .animate(onPlay: (controller) => controller.repeat()) // Repeat animation indefinitely
                    //   .shimmer(duration: 3000.ms), // Apply shimmer effect
                    // Image.asset("assets/A-U-4.jpg")
                    //   .animate(onPlay: (controller) => controller.repeat()) // Repeat animation indefinitely
                    //   .shimmer(duration: 3000.ms), // Apply shimmer effect


                    SizedBox(
                      height: 450,
                      width: 400,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            left: 0,
                            child: Image.asset(
                              "assets/A-U-1.jpg",
                              height: 200,
                              width: 180,
                              fit: BoxFit.cover,
                            )
                              .animate(onPlay: (controller) => controller.repeat(reverse: true)) // Smooth repeat
                              //.shimmer(duration: 3000.ms)
                              .boxShadow(duration: 1000.ms,
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
                            child: Image.asset(
                              "assets/A-U-2.jpg",
                              height: 200,
                              width: 180,
                              fit: BoxFit.cover,
                            )
                              .animate(onPlay: (controller) => controller.repeat(reverse: true)) // Smooth repeat
                              //.shimmer(duration: 7000.ms)
                              .boxShadow(duration: 1100.ms,
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
                            child: Image.asset(
                              "assets/A-U-3.jpg",
                              height: 200,
                              width: 180,
                              fit: BoxFit.cover,
                            )
                              .animate(onPlay: (controller) => controller.repeat(reverse: true)) // Smooth repeat
                              //.shimmer(duration: 7000.ms)
                              .boxShadow(duration: 1200.ms,
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
                            child: Image.asset(
                              "assets/A-U-4.jpg",
                              height: 200,
                              width: 180,
                              fit: BoxFit.cover,
                            )
                              .animate(onPlay: (controller) => controller.repeat(reverse: true)) // Smooth repeat
                              //.shimmer(duration: 7000.ms)
                              .boxShadow(duration: 1300.ms,
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
                      //border: TableBorder.all(color: Colors.grey), // Border for the table
                      children: [
                        TableRow(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "50+",
                                    style: TextStyle(fontSize: 30, color: ui.Color.fromARGB(255, 168, 168, 168)),
                                  ).animate(onPlay: (controller) => controller.repeat())
                                    .shimmer(duration: 3000.ms, color: Colors.deepOrange),
                                  const Text(
                                    "Project",
                                    style: TextStyle(fontSize: 17, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "30+",
                                    style: TextStyle(fontSize: 30, color: ui.Color.fromARGB(255, 168, 168, 168)),
                                  ).animate(onPlay: (controller) => controller.repeat())
                                    .shimmer(duration: 3000.ms, color: Colors.deepOrange),
                                  const Text(
                                    "Clients et partenaires",
                                    style: TextStyle(fontSize: 17, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "6",
                                    style: TextStyle(fontSize: 30, color: ui.Color.fromARGB(255, 168, 168, 168)),
                                  ).animate(onPlay: (controller) => controller.repeat())
                                    .shimmer(duration: 3000.ms, color: Colors.deepOrange),
                                  const Text(
                                    "Années d'expérience",
                                    style: TextStyle(fontSize: 17, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "2",
                                    style: TextStyle(fontSize: 30, color: ui.Color.fromARGB(255, 168, 168, 168)),
                                  ).animate(onPlay: (controller) => controller.repeat())
                                    .shimmer(duration: 3000.ms, color: Colors.deepOrange),
                                  const Text(
                                    "Filiales",
                                    style: TextStyle(fontSize: 17, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
        //             .animate(onPlay: (controller) => controller.repeat())
        // .shimmer(duration: 1200.ms, color: ui.Color.fromARGB(255, 192, 41, 0))
        // .animate() // this wraps the previous Animate in another Animate
        // .fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad)
        // .slide(),

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
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => AboutUsView()),
                            // );
                    
                            Navigator.pushNamed(context, '/contact');
                            print('Navigating to ContactView...');
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