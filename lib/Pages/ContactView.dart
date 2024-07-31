import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

class ContactView extends StatelessWidget {
  const ContactView({super.key});

Future<void> _launchURL(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
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
                            icon: Image.asset('assets/linked4.png', width: 45, height: 45),
                            onPressed: () => _launchURL('https://www.linkedin.com'),
                          ),
                          const SizedBox(width: 0),
                          IconButton(
                            icon: Image.asset('assets/face5.png', width: 45, height: 45),
                            onPressed: () => _launchURL('https://www.facebook.com'),
                          ),
                          const SizedBox(width: 0),
                          IconButton(
                            icon: Image.asset('assets/insta4.png', width: 45, height: 45),
                            onPressed: () => _launchURL('https://www.instagram.com'),
                          ),
                          const SizedBox(width: 0),
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

  Widget _buildForm(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    String name = "";
    String email = "";
    String phone = "";
    String subject = "";
    String message = "";

    void _submit(BuildContext context) {
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
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                child:
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      FocusScope.of(context).unfocus();
                      _formKey.currentState?.reset();
                    },
                  )
              )
            ],
          );
        },
      );
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Message cannot be empty';
              }
              if (value.length < 10) { // Ensure the message is at least 10 characters long
                return 'Message must contain at least 10 characters';
              }
              // Define the regex pattern to allow letters, numbers, spaces, and common punctuation
              //final messageRegex = RegExp(r'^[\w\s.,!?\'"-]+$');
              final messageRegex = RegExp(r'^[\w\s]+$');
              if (!messageRegex.hasMatch(value)) {
                return 'Message can only contain letters, numbers, and basic punctuation';
              }
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
                  _submit(context);
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
            ),
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
