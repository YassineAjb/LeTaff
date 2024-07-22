import 'package:flutter/material.dart';
import 'package:rive_animated_icon/rive_animated_icon.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});


//
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }
//
  
  @override
  Widget build(BuildContext context) {
    // List of image paths
    final List<String> imagePaths = [
      'assets/creative1Logo.png',
      'assets/creative2Logo.png',
      'assets/innovateLogo.png',
      'assets/EXPRESSLogo.png',
      'assets/BRANDNAMELogo.png',
      'assets/NAMELogo.png',
    ];

    // Data for services containers
    final List<Map<String, dynamic>> servicesData = [
      {
        'title': 'SOLUTIONS WEB',
        'description':
            'Nous mettons à votre disposition notre expertise pour répondre de manière globale à vos besoins en ligne\n\n+ Site Web Vitrine\n+ Site Web E-Commerce\n+ Site Web sur mesure',
        'buttonText': 'Details',
        'buttonAction': () {
          // Define your button action here
          print("Details for SOLUTIONS WEB");
        },
        'image': 'assets/webdev.png',
      },
      {
        'title': 'DÉVELOPPEMENT MOBILE',
        'description':
            'Nous créons des applications mobiles performantes et adaptées à vos besoins\n\n+ Applications iOS\n+ Applications Android\n+ Applications cross-platform',
        'buttonText': 'En savoir plus',
        'buttonAction': () {
          // Define your button action here
          print("Details for DÉVELOPPEMENT MOBILE");
        },
        'image': 'assets/mobiledev.png',
      },
      {
        'title': 'MARKETING DIGITAL',
        'description':
            'Nous vous aidons à accroître votre visibilité en ligne et à atteindre vos objectifs commerciaux\n\n+ SEO\n+ SEA\n+ Réseaux sociaux',
        'buttonText': 'Contactez-nous',
        'buttonAction': () {
          // Define your button action here
          print("Details for MARKETING DIGITAL");
        },
        'image': 'assets/marketing.png',
      },
      {
        'title': 'CONCEPTION GRAPHIQUE',
        'description':
            'Nous créons des designs uniques et attrayants pour vos supports de communication\n\n+ Logos\n+ Chartes graphiques\n+ Print et digital',
        'buttonText': 'Voir nos travaux',
        'buttonAction': () {
          // Define your button action here
          print("Details for CONCEPTION GRAPHIQUE");
        },
        'image': 'assets/maintenance.png',
      },
    ];

// Data for services containers
    final List<Map<String, dynamic>> ProjectData = [
      {
        'title': 'ACADEMINY',
        'image': 'assets/hom2.png',
      },
      {
        'title': 'SAVONNERIE\nZEN',
        'image': 'assets/hom2.png',
      },
      {
        'title': 'ABSQJ',
        'image': 'assets/hom2.png',
      },
      {
        'title': 'CLINIQUE RADIOLOGIQUE',
        'image': 'assets/hom2.png',
      },
    ];

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            // Spacer
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            
            // Hero Section
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    height: 200,
                    color: const Color.fromARGB(255, 0, 0, 0),
                    child: Center(
                      child: Image.asset('assets/le-taff-logo-1.png'),
                    ),
                  ),
                  const Divider(
                    color: Colors.grey, // Color of the divider
                    thickness: 1, // Thickness of the divider
                    indent: 30, // Indentation from the start (leading edge)
                    endIndent: 30, // Indentation from the end (trailing edge)
                  ),
                ],
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            
            // Featured Sections  
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and subtitle
                    const Text(
                      "AGENCE DE SERVICES",
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 30.0,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "NUMÉR",
                      style: TextStyle(
                        color: Color.fromARGB(255, 193, 193, 193),
                        fontSize: 70.0,
                        height: 0.9,
                      ),
                    ),
      
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start, // Aligns children to start vertically
                      children: [
                        Expanded(
                          child: Text(
                            " ",
                            style: TextStyle(
                              color: Color.fromARGB(255, 151, 151, 151),
                              fontSize: 19.0,
                              height: 1.5,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "IQUES",
                          style: TextStyle(
                            color: Color.fromARGB(255, 193, 193, 193),
                            fontSize: 70.0,
                            height: 0.9,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
      
                    const Text(
                      "Nous sommes une Agence de services numériques spécialisée dans la conception et le développement sur mesure de sites web, d'applications mobiles et logicielles. De plus, nos solutions sont adaptées aux besoins de toutes sortes d'entreprises.",
                      style: TextStyle(
                        color: Color.fromARGB(255, 151, 151, 151),
                        fontSize: 19.0,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                    RiveAnimatedIcon(
                        riveIcon: RiveIcon.arrowDown,
                        width: 58,
                        height: 70,
                        color: const Color.fromARGB(255, 255, 255, 255),
                        strokeWidth: 3,
                        loopAnimation: true,
                        onTap: (){},
                        onHover: (value){}                          
                    ),
                        const SizedBox(width: 10),
                        Container(
                          height: 175,
                          color: const Color.fromARGB(255, 0, 0, 0),
                          child: Center(
                            child: Image.asset('assets/hom11.jpg'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
      
                    const Center(
                      child: Text(
                        "NOS PARTENAIRES",
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 28.0,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Center(
                      child: Text(
                        "DE CONFIANCE",
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 28.0,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  
                    // Grid view of cards
                    // GridView.builder(
                    //   shrinkWrap: true,
                    //   physics: const NeverScrollableScrollPhysics(),
                    //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount: 3,
                    //     crossAxisSpacing: 16,
                    //     mainAxisSpacing: 16,
                    //   ),
                    //   itemCount: 6,
                    //   itemBuilder: (context, index) {
                    //     return Card(
                    //       elevation: 4,
                    //       child: Image.asset('assets/EXPRESSLogo.png', fit: BoxFit.cover),
                    //     );
                    //   },
                    // ),
                      
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
                              child: Image.asset(imagePaths[index], fit: BoxFit.cover),
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
                    const Text(
                      "SERVICES",
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold, // This makes the text bold
                      ),
                    ),
                    const Center(
                      child: Text(
                        "NOTRE GAMME DE SERVICES NUMÉRIQUE DE VALEUR",
                        textAlign: TextAlign.center, // Center-align all lines
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 33.0,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ),
      
                    const Center(
                      child: Text(
                        "Nous sommes une agence innovante, spécialisée dans la fourniture de services numériques et de solutions web de haute qualité. En outre, notre expertise englobe la création d'applications mobiles sur mesure, la mise en place de stratégies de marketing efficaces, la conception graphique créative et bien plus encore.",
                        //textAlign: TextAlign.center, // Center-align all lines
                        style: TextStyle(
                          color: Color.fromARGB(255, 117, 117, 117),
                          fontSize: 20.0,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Horizontal line (Divider)
                    const Divider(
                      color: Colors.grey, // Color of the divider
                      thickness: 1, // Thickness of the divider
                      indent: 20, // Indentation from the start (leading edge)
                      endIndent: 20, // Indentation from the end (trailing edge)
                    ),
      
                    const SizedBox(height: 40),        
                    // Horizontal Scroll of service containers
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: servicesData.map((service) {
                          return Container(
                            width: 340,
                            height: 340,
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
                                Text(
                                  service['title'],
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 216, 216, 216),
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                Text(
                                  service['description'],
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 16.0,
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      onPressed: service['buttonAction'],
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.deepOrange,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            service['buttonText'],
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                          const Icon(
                                            Icons.moving,
                                            color: Colors.black,
                                            size: 30,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Image.asset(
                                        service['image'],
                                        width: 80,
                                        height: 80,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 40),        
                    
                    Container(
                            width: 400,
                            height: 600,
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
                              image: const DecorationImage(
                                image: AssetImage('assets/QuiNous.jpg'), 
                                fit: BoxFit.cover, 
                                opacity: 0.1, 
                              ),
                            ),
                          child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start
                          children: [
                          Text(
                            "QUI SOMMES-NOUS ?",
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 28.0,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.bold, 
                            ),
                          ),
                          SizedBox(height: 10.0), // Add space between the texts
                          Text(
                            "LE TAFF - AGENCE DE SERVICES NUMÉRIQUES ET DIGITAL",
                            style: TextStyle(
                              color: Color.fromARGB(255, 216, 216, 216),
                              fontSize: 25.0,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.bold, 
                            ),
                          ),
                          Text(
                            "Notre équipe est composée de développeurs passionnés par les dernières avancées technologiques, et nous proposons une vaste gamme de services pour répondre à vos besoins. De plus, notre expertise englobe la création de sites web vitrines élégants, le développement d'applications mobiles sophistiquées, la mise en place de plateformes e-commerce performantes, ainsi que des solutions d'hébergement et d'infogérance de pointe. En outre, nous excellons dans le domaine du référencement (SEO), des audits techniques, de la formation, et bien d'autres prestations. Faites nous confiance pour concrétiser vos projets digitaux et atteindre vos objectifs en ligne.",
                            style: TextStyle(
                            color: Color.fromARGB(255, 190, 190, 190),
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold, 
                            ),
                          ),
                          /*ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrange, // Use `primary` instead of `backgroundColor`
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Savoir Plus",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(width: 8.0), // Add some space between text and icon
                                Icon(
                                  Icons.arrow_forward, // Use a different icon to avoid invalid constant
                                  color: Colors.black,
                                  size: 30,
                                ),
                              ],
                            ),
                          )*/
                        ],
                      ),
                    ),
          
                    const SizedBox(height: 40),        
                    const Text(
                      "Travaux réalisés",
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 40.0,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold, // This makes the text bold
                      ),
                    ),
                    const SizedBox(height: 20),        
                    // Horizontal Scroll of projects containers
SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: Row(
    children: ProjectData.map((Project) {
      return Container(
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
                Project['image'],
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
                child: AnimatedOpacity(
                  opacity: _opacity,
                  duration: Duration(seconds: 1),
                child: Text(
                  Project['title'],
                  style: const TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),),
            ],
          ),
        ),
      );
    }).toList(),
  ),
),

                    const SizedBox(height: 40),

                    // Grid view of cards                  
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: 26,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 4,
                          child: Column(
                            children: [
                              Expanded(
                                child: Image.asset('assets/onboard_two.png', fit: BoxFit.cover),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Item ${index + 1}',
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ),
      ),
    );
  }
}
