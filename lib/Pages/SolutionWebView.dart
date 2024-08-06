import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:video_player/video_player.dart';

class SolutionWebView extends StatefulWidget {
  @override
  _SolutionWebViewState createState() => _SolutionWebViewState();
}

class _SolutionWebViewState extends State<SolutionWebView> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const ui.Color.fromARGB(255, 0, 0, 0), // Change this to your desired background color
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white), // Change this to your desired icon color
            onPressed: () {
              Navigator.pop(context);
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
                    height: 100,
                    color: ui.Color.fromARGB(255, 0, 0, 0),
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
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "Nous sommes­ une­ agence­ de­ développement­ à­ service­ complet,­ dédiée­ à­ vous­ offrir­ les­ meilleurs­résultats.",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 30.0,
                        height: 1.2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
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
}
