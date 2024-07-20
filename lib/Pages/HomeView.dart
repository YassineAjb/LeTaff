import 'package:flutter/material.dart';
import 'package:rive_animated_icon/rive_animated_icon.dart';

class HomeView extends StatelessWidget {
  
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

    return Scaffold(
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

                  // Services container
                  Container(
                      padding: const EdgeInsets.all(16.0), // Padding inside the container
                      margin: const EdgeInsets.symmetric(horizontal: 20.0), // Margin around the container
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 24, 24, 24), // Background color of the container
                        borderRadius: BorderRadius.circular(10.0), // Rounded corners
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5), // Shadow color
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3), // Shadow position
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start
                        children: [
                          const Text(
                            "SOLUTIONS WEB",
                            style: TextStyle(
                              color: Color.fromARGB(255, 216, 216, 216),
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10.0), // Space between title and text
                          Text(
                            "Nous mettons à votre disposition notre expertise pour répondre de manière globale à vos besoins en ligne\n\n"
                            "+ Site Web Vitrine\n"
                            "+ Site Web E-Commerce\n"
                            "+ Site Web sur mesure",
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 16.0,
                            ),
                          ),

                          const SizedBox(height: 20.0), // Space between text and button
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                // Define your button action here
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepOrange, // Button color
                              ),
                              child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              //mainAxisAlignment: MainAxisAlignment.start, 
                              //mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Details",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                Icon(
                                  Icons.moving, 
                                  color: Colors.black,
                                  size: 30, 
                                ),
                              ],
                            ),
                            ),
                          ),
                        ],
                      ),
                    ),

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
    );
  }
}
