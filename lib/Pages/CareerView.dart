import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:letaff/Pages/ServicesView.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
//import 'dart:ui' as ui;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class CareerView extends StatefulWidget {
  @override
  _CareerViewState createState() => _CareerViewState();
}

class _CareerViewState extends State<CareerView> {

  final firebase_storage.FirebaseStorage _storage = firebase_storage.FirebaseStorage.instance;
  Map<String, String?> imageUrls = {}; // Map to store URLs
  //String? _videoUrl;

  late VideoPlayerController _controller;

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> postesData = [];

  @override
  void initState() {
    super.initState();
    _fetchImages();
    _fetchPostes(); // Fetch data when the screen is initialized
    _fetchVideoUrl();
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
    String videoUrl = await _storage.ref('images/REJOIGNEZNOUSvd.mp4').getDownloadURL();
    
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

Future<void> _fetchPostes() async {
    try {
      // Fetch data from Firestore
      QuerySnapshot snapshot = await _firestore.collection('poste').get();
      setState(() {
        postesData = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      });
    } catch (e) {
      print("Error fetching postes: $e");
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
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

final List<Map<String, dynamic>> conseilData = [
      {
        'title': "Comment réaliser votre CV?",
        'descreption': "Le CV est votre carte d’identité professionnelle qui permet de savoir si vous correspondez ou non au profil recherché.\n\nIl faut donc l’adapter selon l’offre proposée par LETAFF. Ceci montre que vous avez porté une attention particulière à l’entreprise ainsi qu’à la mission du poste et peut jouer en votre faveur devant un nombre de candidature important.\n\nIl faut également mettre en valeur les points en commun entre l’offre et votre parcours en identifiant les points de concordance de ces derniers.\n\nEnfin, il est important d’utiliser le vocabulaire de l’entreprise et du secteur en s’inspirant directement de l’offre ou encore des autres annonces diffusées.\n\n",
      },
      {
        'title': 'Comment rédiger votre lettre de motivation ?',
        'descreption': 'La lettre de motivation est un élément clé de votre candidature. Celle-ci nous permet d’estimer votre motivation et la cohérence de votre parcours et de votre projet professionnel avec le poste proposé. Votre lettre doit compléter votre CV et attiser notre curiosité. Pour ce faire, avant de rédiger votre lettre, prenez le temps d’analyser l’annonce pour préparer votre argumentaire. Pour cela, mettez en lien les besoins de l’entreprise et les réponses que vous pouvez apporter. Vous devez témoigner de votre intérêt pour l’entreprise, de votre compréhension du poste et mettre en adéquation le profil recherché et vos points forts. Reliez vos expériences et vos activités extra-professionnelles au besoin de l’entreprise. Restez concret, direct et clair.\n\nPour finir, relisez et faites relire votre CV et votre lettre de motivation car les fautes d’orthographe sont rédhibitoires.',
      },
      {
        'title': 'Quelques conseils pour réussir votre entretien',
        'descreption': "L’entretien est un échange privilégié avec le recruteur. Vous souhaitez mieux comprendre le poste proposé et LETAFF souhaite mieux vous connaître. Suivez l’activité d’LETAFF et relisez bien l’annonce à laquelle vous avez postulé. Demandez-vous pourquoi LETAFF vous choisirait plutôt qu’un autre candidat et listez vos atouts. Préparez vos questions. Choisissez une tenue neutre et soignée. Ayez une posture droite et soyez enthousiaste. Votre discours doit être structuré et cohérent. Présentez vos compétences et vos expériences en les reliant aux missions proposées. Vous devez convaincre votre interlocuteur que vous êtes fait pour le poste.\n\nEnfin, posez des questions sur l’entreprise, ses valeurs, sa culture ou son actualité. Vous devez montrer tout votre intérêt pour LETAFF.",
      },
    ];

Widget buildPostesListe() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: postesData.map((poste) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Container(
          decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 49, 49, 49),
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 127, 127, 127).withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    poste['title'],
                    style:const TextStyle(
                      //color: const Color.fromARGB(255, 255, 255, 255),
                      color:Color.fromARGB(255, 255, 255, 255),
                      fontSize: 20.0,
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0), 
                  child: Text(
                    poste['description'],
                    style: const TextStyle(
                      color: Color.fromARGB(255, 156, 156, 156),
                      fontSize: 20.0,
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _launchURL(poste['link']); 
                      print("Form for ${poste['title']}"); 
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), 
                        side: const BorderSide(
                          color: Color.fromARGB(255, 115, 115, 115), 
                          width: 1.5, 
                        ),
                      ),
                      // padding: EdgeInsets.zero, 
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Postuler',
                          style: TextStyle(
                            color: Colors.deepOrange,
                          ),
                        ),
                        SizedBox(width: 5.0),
                        Icon(
                          Icons.moving,
                          color: Colors.deepOrange,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
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
                  _isVideoLoaded
                    ? AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      )
                    : /*Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min, // Center the content vertically
                          children: [
                            const SizedBox(height: 10),
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
                      ),*/
                      buildCircularIndicatorWithImage(),
                ],
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 0, 0, 0),
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
                          const Text(
                            "Pourquoi LETAFF ?",
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Nous vous proposons un environnement de travail stimulant et offrant de nombreuses opportunités.",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ).animate(onPlay: (controller) => controller.repeat())
                            .shimmer(duration: 3000.ms, color: const Color.fromARGB(255, 255, 179, 156)),
                          const SizedBox(height: 20),
                          const Text(
                            "En rejoignant LETAFF, vous intégrez une équipe composée d’experts avec une expérience éprouvée dans différents domaines tels que le développement mobile, le marketing, la maintenance, et les solutions web. Cette séniorité de l’équipe vous permet d’accélérer votre développement professionnel.",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ).animate(onPlay: (controller) => controller.repeat())
                            .shimmer(duration: 3500.ms, color: const Color.fromARGB(255, 255, 179, 156)),
                          const SizedBox(height: 20),
                          const Text(
                            "La priorité de LETAFF est d’offrir à tous ses collaborateurs un environnement de travail convivial qui développe leur excellence. LETAFF, c’est aussi une présence internationale avec des bureaux en Tunisie et au Canada. Cette diversité géographique permet de vous fournir un développement personnel de grande qualité.",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ).animate(onPlay: (controller) => controller.repeat())
                            .shimmer(duration: 4000.ms, color: const Color.fromARGB(255, 255, 179, 156)),
                          const SizedBox(height: 20),
                          const Text(
                            "De plus, lors de votre première semaine au sein de LETAFF, vous bénéficierez de la LETAFF Academy où vous aurez l’occasion de découvrir ou d’approfondir vos connaissances dans nos différents domaines d'expertise.",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ).animate(onPlay: (controller) => controller.repeat())
                            .shimmer(duration: 4500.ms, color: const Color.fromARGB(255, 255, 179, 156)),
                          const SizedBox(height: 30),
                          const Text(
                            "Nos Valeurs",
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                         Wrap(
                            spacing: 7.0,
                            runSpacing: 10.0,
                            children: [
                              ToggleTextContainer(
                                initialText: "Savoir-être\nSavoir-faire",
                                toggledText: "Le professionnalisme et la qualité du travail effectué par les équipes LETAFF sur le terrain font partie de nos caractéristiques maîtresses",
                              ),
                              ToggleTextContainer(
                                initialText: "Ouverture\nd'esprit",
                                toggledText: "Notre diversité est notre force. Que cela soit culturel ou professionnel, nos équipes bénéficient d’une grande variété de background",
                              ),
                              ToggleTextContainer(
                                initialText: "Esprit\nd'équipe",
                                toggledText: "Chez LETAFF, vous pourrez toujours compter sur l’expertise et la disponibilité de chacun de nos experts",
                              ),
                              ToggleTextContainer(
                                initialText: "Adaptabilité",
                                toggledText: "Il n’est jamais simple de séparer vie professionnelle et vie privée. Notre adaptabilité vous permettra de vous offrir un cadre de travail adéquat",
                              ),
                              ]
                              ),
                              const SizedBox(height: 30),
                              
                              hr,
                              const Center(
                                child: Text(
                                  "Postuler",
                                  style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),

                              // Display list of postes
                              buildPostesListe(),
                              const SizedBox(height: 20),

                              const Center(
                                child: Text(
                                    "Nos conseils pour postuler :",
                                    style: TextStyle(
                                      color: Colors.deepOrange,
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                              ),
                              const SizedBox(height: 20),

                    SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: conseilData.map((data) {
                                return Container(
                                  padding: const EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 49, 49, 49),
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
                                  height: 1000,
                                  width: 328,
                                  margin: const EdgeInsets.only(right: 16.0), // Add spacing between containers
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data['title'] ?? 'No Title',
                                        style: const TextStyle(
                                          color: Color.fromARGB(255, 255, 184, 162),
                                          fontSize: 35,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        data['descreption'] ?? 'No Description',
                                        style: const TextStyle(
                                          color: Color.fromARGB(255, 176, 176, 176),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(height: 30),
                          hr,
                          
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
                                ],
                              ),
                            ),





                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
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

class ToggleTextContainer extends StatefulWidget {
  final String initialText;
  final String toggledText;

  ToggleTextContainer({required this.initialText, required this.toggledText});

  @override
  _ToggleTextContainerState createState() => _ToggleTextContainerState();
}

class _ToggleTextContainerState extends State<ToggleTextContainer> {
  bool _isFirstTextVisible = true;

  void _toggleText() {
    setState(() {
      _isFirstTextVisible = !_isFirstTextVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleText,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
        child: Container(
          key: ValueKey<bool>(_isFirstTextVisible),
          height: 290,
          width: 170,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 31, 31, 31),
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: const AssetImage('asset/ContCareer.png'), 
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.7), 
                BlendMode.darken,
              ),
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _isFirstTextVisible ? widget.initialText : widget.toggledText,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
