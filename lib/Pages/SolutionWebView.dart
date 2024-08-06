import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:letaff/Pages/ContactView.dart';

class SolutionWebView extends StatefulWidget {
  @override
  _SolutionWebViewState createState() => _SolutionWebViewState();
}

class _SolutionWebViewState extends State<SolutionWebView> {
  

  @override
  void initState() {
    super.initState();
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
            'Solution Web',
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
                      child: Image.asset('assets/solutions-webjpg.jpg'),
                    ),
                  ),
                  // const Divider(
                  //   color: Colors.grey,
                  //   thickness: 1,
                  //   indent: 30,
                  //   endIndent: 30,
                  // ),
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
                      "Nous nous engageons à développer des solutions web sur mesure, que ce soit pour des applications, des sites vitrines ou des plateformes e-commerce, afin de répondre à tous vos besoins en ligne.",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 22.0,
                        height: 1.2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "notre engagement envers l'excellence se traduit par une approche rigoureuse de chaque projet, garantissant des résultats remarquables en termes de conception et de développement.",
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
                                '+ Laravel',
                                style: TextStyle(color: ui.Color.fromARGB(255, 236, 236, 236),fontSize: 22,), // Set text color
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                '+ JavaScript',
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
                                '+ Vue Js',
                                style: TextStyle(color: ui.Color.fromARGB(255, 236, 236, 236),fontSize: 22,), // Set text color
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                '+ WordPress',
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
                                '+ PHP',
                                style: TextStyle(color: ui.Color.fromARGB(255, 236, 236, 236),fontSize: 22,), // Set text color
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                '+ Dévelopment Front End',
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
      title: const Text('Réalisation du CDC et Estimation devis',
      style: TextStyle(color: Colors.deepOrange,fontSize: 20,),
      ).animate(onPlay: (controller) => controller.repeat())
        .shimmer(duration: 4000.ms, color: const ui.Color.fromARGB(255, 255, 158, 129)),
    ),
const Text('Notre première étape cruciale pour concevoir nos solutions web C’est à partir de ce document que nous pourrons estimer avec précision le devis.',
style: TextStyle(color: ui.Color.fromARGB(255, 236, 236, 236),fontSize: 18,),
),
     ListTile(
      leading: const Icon(Icons.circle,size: 13,color: Colors.deepOrange)
      .animate(onPlay: (controller) => controller.repeat())
                .shimmer(duration: 4000.ms, color: const ui.Color.fromARGB(255, 226, 185, 172)),
      title: const Text('Conception et Développement',
      style: TextStyle(color: Colors.deepOrange,fontSize: 20,),
      ).animate(onPlay: (controller) => controller.repeat())
        .shimmer(duration: 4000.ms, color: ui.Color.fromARGB(255, 255, 158, 129)),
    ),
    const Text('Nous commençons par analyser les besoins fonctionnels et nos spécifications, puis nous procédons au développement du site en fonction de ces données.',
    style: TextStyle(color: ui.Color.fromARGB(255, 236, 236, 236),fontSize: 18,),
    ),
    ListTile(
      leading: const Icon(Icons.circle,size: 13,color:  Colors.deepOrange)
      .animate(onPlay: (controller) => controller.repeat())
                .shimmer(duration: 4000.ms, color: const ui.Color.fromARGB(255, 226, 185, 172)),
      title: const Text('L’adaptation du méthodologie agiles',
      style: TextStyle(color:Colors.deepOrange ,fontSize: 20,),)
      .animate(onPlay: (controller) => controller.repeat())
        .shimmer(duration: 4000.ms, color: ui.Color.fromARGB(255, 255, 158, 129)),
    ),
    const Text('Notre première étape cruciale pour concevoir nos solutions web C’est à partir de ce document que nous pourrons estimer avec précision le devis.',
    style: TextStyle(color:ui.Color.fromARGB(255, 236, 236, 236),fontSize: 18,),
    ),
    ListTile(
      leading: const Icon(Icons.circle,size: 13,color:  Colors.deepOrange)
      .animate(onPlay: (controller) => controller.repeat())
                .shimmer(duration: 4000.ms, color: const ui.Color.fromARGB(255, 226, 185, 172)),
      title: const Text('Mise en production et suivi de maintenance',
      style: TextStyle(color:Colors.deepOrange,fontSize: 20,),
      ).animate(onPlay: (controller) => controller.repeat())
        .shimmer(duration: 4000.ms, color: ui.Color.fromARGB(255, 255, 158, 129)),
    ),
    const Text('Une formation est dispensée au client, inclus d’une période de suivi et de maintenance pour garantir le bon fonctionnement continu de son système.',
    style: TextStyle(color: ui.Color.fromARGB(255, 236, 236, 236),fontSize: 18,),
    ),
  ],
),
const SizedBox(height: 30),



const Text(
"Nous proposons des applications web avec l’une des meilleures structures organisées : CMS ou codage.",
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
    child: Image.asset('assets/service-detail.png'),
  ),
),
const SizedBox(height: 10),

                    const Text(
                      "Notre expertise en matière de développement de logiciels, et nous nous distinguons par notre maîtrise des technologies de pointe telles que Vue.js, Laravel, React et Node.js. Grâce à notre expertise, nous sommes en mesure de concevoir et de créer des solutions web avancée.",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 22.0,
                        height: 1.2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Nous excels dans le développement de logiciels et la création de solutions web avancées en utilisant une variété de CMS tels que WordPress, PrestaShop, Drupal, Shopify, et bien d’autres encore. Notre expertise nous permet de choisir le CMS qui répond le mieux à vos besoins spécifiques pour des résultats exceptionnels.",
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
    child: Image.asset('assets/S o l u t i o n s W e b.png'),
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
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const ContactView()),
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
