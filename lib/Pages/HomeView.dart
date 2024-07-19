import 'package:flutter/material.dart';
import 'package:rive_animated_icon/rive_animated_icon.dart';

class HomeView extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Spacer
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          
          // Hero Section
          SliverToBoxAdapter(
            child: Container(
              height: 200,
              color: const Color.fromARGB(255, 0, 0, 0),
              child: Center(
                child: Image.asset('assets/le-taff-logo-1.png'),
              ),
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
                  // Description with a multiline text
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start, // Aligns children to start vertically
                    children: [
                      Expanded(
                        child: Text(
                          "Nous sommes une Agence de services",
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
                  const Text(
                    "numériques spécialisée dans la conception et le développement sur mesure de sites web, d'applications mobiles et logicielles. De plus, nos solutions sont adaptées aux besoins de toutes sortes d'entreprises.",
                    style: TextStyle(
                      color: Color.fromARGB(255, 151, 151, 151),
                      fontSize: 19.0,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      // const Expanded(
                      //   child: Text(
                      //     "text",
                      //     style: TextStyle(
                      //       color: Color.fromARGB(255, 193, 193, 193),
                      //       fontSize: 19.0,
                      //       height: 0.9,
                      //     ),
                      //   ),
                      // ),
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
