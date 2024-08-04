import 'package:flutter/material.dart';

class ServicesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            "LETAFF",
            style: TextStyle(color: Colors.deepOrange),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            Container(
              height: 200.0,
              color: Colors.deepOrangeAccent,
              child: const Center(
                child: Text(
                  "Hero Section",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Features Section
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Features",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  featureCard("Feature 1", "Description of Feature 1"),
                  featureCard("Feature 2", "Description of Feature 2"),
                  featureCard("Feature 3", "Description of Feature 3"),
                ],
              ),
            ),
            // Testimonials Section
            Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.grey[200],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Testimonials",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  testimonialCard("User 1", "This is a testimonial from User 1"),
                  testimonialCard("User 2", "This is a testimonial from User 2"),
                ],
              ),
            ),
            // Footer Section
            Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.black,
              child: const Center(
                child: Text(
                  "Footer",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget featureCard(String title, String description) {
    return Card(
      margin: const EdgeInsets.only(top: 10.0),
      child: ListTile(
        title: Text(title),
        subtitle: Text(description),
      ),
    );
  }

  Widget testimonialCard(String user, String testimonial) {
    return Card(
      margin: const EdgeInsets.only(top: 10.0),
      child: ListTile(
        title: Text(user),
        subtitle: Text(testimonial),
      ),
    );
  }
  }
