import 'dart:ui' as ui;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
// import 'package:letaff/Pages/ContactView.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:letaff/Pages/ServicesView.dart';
import 'package:letaff/providers/NavBarProvider.dart';
import 'package:provider/provider.dart';

class SolutionMarketingView extends StatefulWidget {
  @override
  _SolutionMarketingViewState createState() => _SolutionMarketingViewState();
}

class _SolutionMarketingViewState extends State<SolutionMarketingView> {

    final firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;

  Map<String, String?> imageUrls = {}; // Map to store URLs

  @override
  void initState() {
    super.initState();
    _fetchImages();
  }
  Future<void> _fetchImages() async {
    // List of image paths and their keys
    final images = {
      'dev-1': 'images/marketing-digital.jpg',
      'solM': 'images/S o l u t i o n s Mar.png',
      'SD': 'images/service-detail.png',
      
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
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const ui.Color.fromARGB(255, 0, 0, 0), // Change this to your desired background color
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white), // Change this to your desired icon color
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                // Optionally, you can show a message or handle the situation when there is nothing to pop
                print("Nothing to pop");
              }
            },
          ),
          title: const Text(
            'Marketing Digital',
            style: TextStyle(
              color: Colors.white, // Change this to your desired text color
            ),
          ),
        ),

        body: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    height: 250,
                    width: 390,
                    color: const ui.Color.fromARGB(255, 0, 0, 0),
                    child: Center(
                      child: imageUrls['dev-1'] != null
                          ? CachedNetworkImage(
                              imageUrl: imageUrls['dev-1']!,
                              placeholder: (context, url) => buildCircularIndicatorWithImage(),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            )
                          : buildCircularIndicatorWithImage(),
                          //Image.asset('assets/marketing-digital.jpg'),
                    ),
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
                    "Chaque décision que nous prenons doit répondre à la question cruciale : comment cela vous bénéficier mieux de vos projects ? Nous travaillons à développer des solutions.",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 22.0,
                        height: 1.2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Nous vous aidons au démarrage de votre stratégie grâce à notre expertise et à nos formations, garantissant ainsi des résultats satisfaisants.",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 22.0,
                        height: 1.2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    hr,
                    Table(
                      border: TableBorder.all(color: const ui.Color.fromARGB(255, 20, 20, 20), width: 2.0), 
                      children: const [
                        TableRow(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                '+ Marketing de contenu',
                                style: TextStyle(color: ui.Color.fromARGB(255, 236, 236, 236),fontSize: 22,), // Set text color
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                '+ Marketing par e-mail',
                                style: TextStyle(color: ui.Color.fromARGB(255, 236, 236, 236),fontSize: 22,), // Set text color
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                '+ Publicité',
                                style: TextStyle(color: ui.Color.fromARGB(255, 236, 236, 236),fontSize: 22,), // Set text color
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                '+ Gestion des médias sociaux',
                                style: TextStyle(color: ui.Color.fromARGB(255, 236, 236, 236),fontSize: 22,), // Set text color
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                '+ Analyse de données et reporting',
                                style: TextStyle(color: ui.Color.fromARGB(255, 236, 236, 236),fontSize: 22,), // Set text color
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                '+ Optimisation pour les moteurs de recherche ( SEO )',
                                style: TextStyle(color: ui.Color.fromARGB(255, 236, 236, 236),fontSize: 22,), // Set text color
                              ),
                            ),
                          ],
                        ),
                      ],
                    ).animate(onPlay: (controller) => controller.repeat())
                    .shimmer(duration: 3000.ms, color: const Color.fromARGB(255, 255, 179, 156)),

                    const SizedBox(height: 20),



Column(
  children: <Widget>[
    ListTile(
      leading: const Icon(Icons.circle,size: 13,color:  Colors.deepOrange)
                .animate(onPlay: (controller) => controller.repeat())
                .shimmer(duration: 4000.ms, color: const ui.Color.fromARGB(255, 226, 185, 172)),
      title: const Text('Analyse et Stratégie',
      style: TextStyle(color: Colors.deepOrange,fontSize: 20,),
      ).animate(onPlay: (controller) => controller.repeat())
        .shimmer(duration: 4000.ms, color: const ui.Color.fromARGB(255, 255, 158, 129)),
    ),
const Text('Le marketing digital commence par l’analyser du votre marché et votre public cible, puis développez une stratégie digitale précise.',
style: TextStyle(color: ui.Color.fromARGB(255, 236, 236, 236),fontSize: 18,),
),

     ListTile(
      leading: const Icon(Icons.circle,size: 13,color: Colors.deepOrange)
      .animate(onPlay: (controller) => controller.repeat())
                .shimmer(duration: 4000.ms, color: const ui.Color.fromARGB(255, 226, 185, 172)),
      title: const Text('Conception de Campagnes',
      style: TextStyle(color: Colors.deepOrange,fontSize: 20,),
      ).animate(onPlay: (controller) => controller.repeat())
        .shimmer(duration: 4000.ms, color: ui.Color.fromARGB(255, 255, 158, 129)),
    ),
    const Text('Créez des campagnes sur mesure, en utilisant les canaux appropriés pour votre entreprise ou projets .',
    style: TextStyle(color: ui.Color.fromARGB(255, 236, 236, 236),fontSize: 18,),
    ),

    ListTile(
      leading: const Icon(Icons.circle,size: 13,color:  Colors.deepOrange)
      .animate(onPlay: (controller) => controller.repeat())
                .shimmer(duration: 4000.ms, color: const ui.Color.fromARGB(255, 226, 185, 172)),
      title: const Text('Mise en Œuvre et Gestion',
      style: TextStyle(color:Colors.deepOrange ,fontSize: 20,),)
      .animate(onPlay: (controller) => controller.repeat())
        .shimmer(duration: 4000.ms, color: ui.Color.fromARGB(255, 255, 158, 129)),
    ),
    const Text('La mise en place des campagnes est suivie de près par notre équipe experte. Nous surveillons attentivement leur progression et, si nécessaire, nous apportons des ajustements stratégiques pour garantir des résultats optimaux',
    style: TextStyle(color:ui.Color.fromARGB(255, 236, 236, 236),fontSize: 18,),
    ),

    ListTile(
      leading: const Icon(Icons.circle,size: 13,color:  Colors.deepOrange)
      .animate(onPlay: (controller) => controller.repeat())
                .shimmer(duration: 4000.ms, color: const ui.Color.fromARGB(255, 226, 185, 172)),
      title: const Text('Optimisation Continue',
      style: TextStyle(color:Colors.deepOrange,fontSize: 20,),
      ).animate(onPlay: (controller) => controller.repeat())
        .shimmer(duration: 4000.ms, color: ui.Color.fromARGB(255, 255, 158, 129)),
    ),
    const Text('Le suivi continue les performances, analysez les données, et apportez des ajustements pour maximiser les résultats tout au long de la campagne.',
    style: TextStyle(color: ui.Color.fromARGB(255, 236, 236, 236),fontSize: 18,),
    ),
  ],
),
const SizedBox(height: 30),

const Text(
"Des stratégies de marketing digital structurées",
  style: TextStyle(
    color: Color.fromARGB(255, 255, 255, 255),
    fontSize: 25.0,
    height: 1.2,
    fontWeight: FontWeight.bold,
  ),
),
const SizedBox(height: 20),


Container(
  height: 250,
  width: 390,
  color: const ui.Color.fromARGB(255, 0, 0, 0),
  child: Center(
    child: imageUrls['SD'] != null
      ? CachedNetworkImage(
          imageUrl: imageUrls['SD']!,
          placeholder: (context, url) => buildCircularIndicatorWithImage(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        )
      : buildCircularIndicatorWithImage(),
      //Image.asset('assets/service-detail.png'),
  ),
),
const SizedBox(height: 10),

                    const Text(
                      "Nous offrons une gamme complète de services de marketing digital, comprenant la création de contenu engageant, la gestion des réseaux sociaux pour une présence dynamique, et le marketing par email ciblé. Notre approche stratégique vise à maximiser votre visibilité en ligne et à générer des résultats concrets pour votre entreprise.",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 22.0,
                        height: 1.2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),



                    const SizedBox(height: 20),
                    const Text(
                      "Nous proposons une palette diversifiée de services incluant l’analyse de données et la création de rapports, la publicité sponsorisée pour accroître votre visibilité, et le SEO pour une meilleure optimisation en ligne. Notre approche méthodique garantit des résultats mesurables et un avantage compétitif pour votre entreprise.",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 22.0,
                        height: 1.2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
Container(
  height: 250,
  width: 390,
  color: const ui.Color.fromARGB(255, 0, 0, 0),
  child: Center(
    child: imageUrls['solM'] != null
      ? CachedNetworkImage(
          imageUrl: imageUrls['solM']!,
          placeholder: (context, url) => buildCircularIndicatorWithImage(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        )
      : buildCircularIndicatorWithImage(),
      //Image.asset('assets/S o l u t i o n s Mar.png'),
  ),
),
const SizedBox(height: 30),

Center(
  child: const Text(
        'Notre valeur pour\nvos solutions web',
          style: TextStyle(
            color:Colors.deepOrange,
            fontSize: 33,
          ),
        ).animate(onPlay: (controller) => controller.repeat())
          .shimmer(duration: 4000.ms, color: ui.Color.fromARGB(255, 255, 158, 129)),
),
const SizedBox(height: 15),

Wrap(
  spacing: 15.0,
  runSpacing: 10.0,
  children: [
    ToggleTextContainer(
      initialText: "L’innovation",
      toggledText: "Nous apportons constamment de nouvelles idées et des approches novatrices pour rendre vos projets uniques et en avance sur la concurrence.",
    ),
    ToggleTextContainer(
      initialText: "L’efficacité",
      toggledText: "Notre équipe expérimentée assure une qualité de développement exceptionnelle et une stabilité dans la durée, offrant ainsi une base solide à vos projets.",
    ),
    ToggleTextContainer(
      initialText: "L’adaptabilité ",
      toggledText: "Nous sommes flexibles et capables de nous adapter à vos besoins changeants, assurant ainsi que vos solutions web évoluent en même temps que votre entreprise.",
    ),
    ToggleTextContainer(
      initialText: "La fiabilité",
      toggledText: "Notre équipe expérimentée assure une qualité de développement exceptionnelle et une stabilité dans la durée.",
    ),
    ]
),
const SizedBox(height: 30),

hr,


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
      'N’HÉSITEZ PAS',
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
      "Ensemble, nous assurons la croissance de vos projects.",
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
          height: 315,
          width: 180,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 31, 31, 31),
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: const AssetImage('asset/ContMark.png'), 
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
