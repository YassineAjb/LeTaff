import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ContactView extends StatefulWidget {
  
  @override
  _ContactViewState createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {

  final firebase_storage.FirebaseStorage _storage = firebase_storage.FirebaseStorage.instance;
  Map<String, String?> imageUrls = {}; // Map to store URLs

  @override
  void initState() {
    super.initState();
    _fetchImages();
  }

Future<void> _fetchImages() async {
    // List of image paths and their keys
    final images = {
      'logo': 'images/le-taff-logo-1.png',
      'logoB': 'images/logo-blanc.png',
      
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

Future<void> _launchURL(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
}

  @override
  void dispose() {
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
                      child: 
                        imageUrls['logo'] != null
                          ? CachedNetworkImage(
                              imageUrl: imageUrls['logo']!,
                              placeholder: (context, url) => const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            )
                          : const CircularProgressIndicator(),
                      //Image.asset('assets/le-taff-logo-1.png'),
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
                    const Text(
                      "Contactez Nous",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 70.0,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Nous sommes impatients de vous entendre et de créer quelque chose de spécial ensemble. contactez nous pour toute question",
                      style: TextStyle(
                        color: Color.fromARGB(255, 221, 221, 221),
                        fontSize: 19.0,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 40),
                    GestureDetector(
                      onTap: () => _launchURL('tel:+21620278432'),
                      child: const Text(
                        "+(216) 20-278-432",
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 25.0,
                          height: 0.9,
                          decoration: TextDecoration.underline, // Optional: add underline to indicate it's clickable
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => _launchURL('tel:+5819970283'),
                      child: const Text(
                        "(581)-997-0283",
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 25.0,
                          height: 0.9,
                          decoration: TextDecoration.underline, // Optional: add underline to indicate it's clickable
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => _launchURL('mailto:contact@letaff.com'),
                      child:const Text(
                        "contact@letaff.com",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 25.0,
                          height: 0.9,
                          decoration: TextDecoration.underline, // Optional: add underline to indicate it's clickable
                        ),
                      ),
                    ),                    
                    const SizedBox(height: 20),
                    const Text(
                      "Québec, QC",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 18.0,
                        height: 0.9,
                      ),
                    ),
                    const SizedBox(height: 40),
                    _buildForm(context),
                    const SizedBox(height: 50),
                    
                    const Divider(
                    color: Colors.grey,
                    thickness: 1,
                    indent: 30,
                    endIndent: 30,
                    ),
                    
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
                          
                          // PACKAGE PROBLEM !!!!!!!!!!
                          // IconButton(
                          //   icon: const Icon(Icons.facebook, color: Colors.deepOrange, size: 30,),
                          //   onPressed: () => _launchURL('https://www.facebook.com'),
                          // ),
                          // IconButton(
                          //   icon: Icon(FlutterSocialIcons.linkedin, color: Colors.blue),
                          //   onPressed: () => _launchURL('https://www.linkedin.com'),
                          // ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                        imageUrls['logoB'] != null
                        ? CachedNetworkImage(
                            imageUrl: imageUrls['logoB']!,
                            placeholder: (context, url) => const CircularProgressIndicator(),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                            width: 100,
                            height: 100,
                          )
                        : const CircularProgressIndicator(),
                          // Image.asset(
                          //   'asset/logo-blanc.png', // Replace with your image asset path
                          //   width: 100,
                          //   height: 100,
                          // ),
                          const SizedBox(height: 10),
                          const Text(
                            'Chez Le Taff, nous nous engageons à fournir des services numériques de haute qualité, de solutions web, des applications mobiles personnalisées et des stratégies marketing efficaces.',
                            style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Center(
                      child: Text(
                        'CONTACT',
                        style: TextStyle(
                        color: Color.fromARGB(255, 255, 139, 139),
                          fontSize: 70,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ).animate(onPlay: (controller) => controller.repeat())
                      .shimmer(duration: 1200.ms, color: Colors.deepOrange)
                      .animate()
                      .fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad)
                      .slide(),
                    
                    const SizedBox(height: 40),
                    const Text(
                        '©2024 | Tous droits réservés par Le Taff',
                        style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 10)),
          ],
        ),
      ),
    );
  }

















  Widget _buildForm(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    String name = "";
    String email = "";
    String phone = "";
    String subject = "";
    String message = "";

void submit(BuildContext context) async {
  // Check for internet connection first
  var connectivityResult = await Connectivity().checkConnectivity();

  if (connectivityResult == ConnectivityResult.none) {
    // No internet connection, show error dialog
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('No Internet Connection'),
          content: const Text(
              'Please check your internet connection and try again.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    return; // Exit function if no connection
  }

  // Try submitting the data to Firestore
  try {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection('message').add({
        'name': name,
        'email': email,
        'phone': phone,
        'subject': subject,
        'message': message,
        'sendTime': Timestamp.now(),
      });

      showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Your message has been submitted'),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const Align(
                      alignment: Alignment.topLeft,
                      child: Text("Name:",
                          style: TextStyle(fontWeight: FontWeight.w700))),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(name),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                      alignment: Alignment.topLeft,
                      child: Text("Phone Number:",
                          style: TextStyle(fontWeight: FontWeight.w700))),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("$phone"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                      alignment: Alignment.topLeft,
                      child: Text("Subject:",
                          style: TextStyle(fontWeight: FontWeight.w700))),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("$subject"),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              Center(
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepOrange,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    FocusScope.of(context).unfocus();
                    _formKey.currentState?.reset();
                  },
                ),
              )
            ],
          );
        },
      );
    }
  } catch (e) {
    // Handle any Firestore errors (e.g., server issues, timeouts)
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error Submitting Message'),
          content: Text(
              'An error occurred while submitting your message: $e\nPlease try again later.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
                labelText: 'Name *',
                labelStyle: TextStyle(
                  color: Colors.deepOrange, // Change this to your desired color
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Color.fromARGB(255, 177, 177, 177), width: 1.5),
                ),
                border: OutlineInputBorder()),
            onFieldSubmitted: (value) {
              name = value.capitalize();
            },
            onChanged: (value) {
              name = value.capitalize();
            },
            style:  const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255), // Change this to your desired color for the input text
            ),
            validator: (value) {
              if (value == null || value.isEmpty || value.length < 3) {
                return 'Name must contain at least 3 characters';
              } else if (value.contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                return 'Name cannot contain special characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Email *',
              labelStyle: TextStyle(
                  color: Colors.deepOrange, // Change this to your desired color
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(color: Color.fromARGB(255, 177, 177, 177), width: 1.5),
              ),
              border: OutlineInputBorder(),
            ),
            style:  const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255), // Change this to your desired color for the input text
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an email address';
              }
              // Basic email regex pattern
              final emailRegex = RegExp(
                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
              );
              if (!emailRegex.hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
            onChanged: (value) {
              // Store the email value
              email = value;
            },
          ),

          const SizedBox(height: 20),
          TextFormField(
          decoration: const InputDecoration(
            labelText: 'Phone',
            labelStyle: TextStyle(
                  color: Colors.deepOrange, // Change this to your desired color
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide(color: Color.fromARGB(255, 177, 177, 177), width: 1.5),
            ),
            border: OutlineInputBorder(),
          ),
          style:  const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255), // Change this to your desired color for the input text
            ),
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a phone number';
            }
            // Regex pattern for validating phone numbers
            final phoneRegex = RegExp(r'^[0-9]{8,15}$');
            if (!phoneRegex.hasMatch(value)) {
              return 'Please enter a valid phone number with 10-15 digits';
            }
            return null;
          },
          onChanged: (value) {
            phone = value;
          },
        ),

          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Subject *',
              labelStyle: TextStyle(
                  color: Colors.deepOrange, // Change this to your desired color
            ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(color: Color.fromARGB(255, 177, 177, 177), width: 1.5),
              ),
              border: OutlineInputBorder(),
            ),
            style:  const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255), // Change this to your desired color for the input text
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Subject cannot be empty';
              }
              // Allow letters, numbers, and basic punctuation
              //final subjectRegex = RegExp(r'^[a-zA-Z0-9\s.,!?\'"-]+$');
              final subjectRegex = RegExp(r'^[\w\s]+$');
              if (!subjectRegex.hasMatch(value)) {
                return 'Subject can only contain letters, numbers, and basic punctuation';
              }
              if (value.length < 3) {
                return 'Subject must contain at least 3 characters';
              }
              return null;
            },
            onChanged: (value) {
              subject = value;
            },
          ),

          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Messages *',
              labelStyle: TextStyle(
                  color: Colors.deepOrange, // Change this to your desired color
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(color: Color.fromARGB(255, 177, 177, 177), width: 1.5),
              ),
              border: OutlineInputBorder(),
            ),  
            style:  const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255), // Change this to your desired color for the input text
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Message cannot be empty';
              }
              if (value.length < 10) { // Ensure the message is at least 10 characters long
                return 'Message must contain at least 10 characters';
              }
              // Define the regex pattern to allow letters, numbers, spaces, and common punctuation
              /*final messageRegex = RegExp(r'^[\w\s.,!?]+$');
              if (!messageRegex.hasMatch(value)) {
                return 'Message can only contain letters, numbers, and basic punctuation';
              }*/
              return null;
            },
            onChanged: (value) {
              message = value; // Assuming you have a message variable to store the value
            },
          ),
        
          const SizedBox(height: 20),
          Center( child: SizedBox(
            width: 120, // Adjust to the desired diameter
            height: 120,
            child: ElevatedButton(
              // style: ElevatedButton.styleFrom(
              //     minimumSize: const Size.fromHeight(60)),
              
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  submit(context);
                }
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
                      "Send Messages",textAlign: TextAlign.center,
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
            ).animate(onPlay: (controller) => controller.repeat(reverse: true))
            .shimmer(duration: 4000.ms),
          ),
          ),
        ],
      ),
    );
  }
}
extension StringExtension on String {
  // Method used for capitalizing the input from the form
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
