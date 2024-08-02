import 'package:flutter/material.dart';
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