import 'package:flutter/material.dart';


class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 24, 24, 24),
        title: const Center(
          child: Text(
            "LETAFF",
            style: TextStyle(
              color: Colors.deepOrange,
              letterSpacing: 2.0,
              fontSize: 30.0,
              ),
          ),
        ),
      ),
      
      body: CustomScrollView(
        slivers: [
          // Hero Section
          SliverToBoxAdapter(

            child: Container(
              height: 200,
              color: Color.fromARGB(255, 0, 0, 0),
              child: Center(
                child: 
                Image.asset('assets/le-taff-logo-1.png'),
                
                // Text(
                //   "Welcome to Our App",
                //   style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white),
                // ),
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
                  Text(
                    "Featured",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 10),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: 10, // Number of items
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