import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Animated Text Example')),
        body: Center(
          child: ContactText(),
        ),
      ),
    );
  }
}

class ContactText extends StatefulWidget {
  @override
  _ContactTextState createState() => _ContactTextState();
}

class _ContactTextState extends State<ContactText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<TextStyle> _textStyleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _textStyleAnimation = TextStyleTween(
      begin: TextStyle(
        color: Color.fromARGB(255, 255, 0, 0),
        fontSize: 70,
        fontWeight: FontWeight.bold,
      ),
      end: TextStyle(
        color: Color.fromARGB(255, 0, 110, 49), // Change to any color you want
        fontSize: 90,
        fontWeight: FontWeight.bold,
      ),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _textStyleAnimation,
      builder: (context, child) {
        return Center(
          child: Text(
            'CONTACT',
            style: _textStyleAnimation.value,
          ),
        );
      },
    );
  }
}
