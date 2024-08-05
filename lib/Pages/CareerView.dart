import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:video_player/video_player.dart';

class CareerView extends StatefulWidget {
  @override
  _CareerViewState createState() => _CareerViewState();
}

class _CareerViewState extends State<CareerView> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/REJOIGNEZNOUSvd.mp4')
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
        body: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  _controller.value.isInitialized
                      ? SizedBox(
                          height: 200,
                          child: VideoPlayer(_controller),
                        )
                      : const CircularProgressIndicator(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 0, 0, 0),
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
                          const Text(
                            "Pourquoi LETAFF ?",
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Nous vous proposons un environnement de travail stimulant et offrant de nombreuses opportunités.",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ).animate(onPlay: (controller) => controller.repeat())
                            .shimmer(duration: 3000.ms, color: Color.fromARGB(255, 255, 179, 156)),
                          const SizedBox(height: 20),
                          const Text(
                            "En rejoignant LETAFF, vous intégrez une équipe composée d’experts avec une expérience éprouvée dans différents domaines tels que le développement mobile, le marketing, la maintenance, et les solutions web. Cette séniorité de l’équipe vous permet d’accélérer votre développement professionnel.",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ).animate(onPlay: (controller) => controller.repeat())
                            .shimmer(duration: 3500.ms, color: Color.fromARGB(255, 255, 179, 156)),
                          const SizedBox(height: 20),
                          const Text(
                            "La priorité de LETAFF est d’offrir à tous ses collaborateurs un environnement de travail convivial qui développe leur excellence. LETAFF, c’est aussi une présence internationale avec des bureaux en Tunisie et au Canada. Cette diversité géographique permet de vous fournir un développement personnel de grande qualité.",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ).animate(onPlay: (controller) => controller.repeat())
                            .shimmer(duration: 4000.ms, color: Color.fromARGB(255, 255, 179, 156)),
                          const SizedBox(height: 20),
                          const Text(
                            "De plus, lors de votre première semaine au sein de LETAFF, vous bénéficierez de la LETAFF Academy où vous aurez l’occasion de découvrir ou d’approfondir vos connaissances dans nos différents domaines d'expertise.",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ).animate(onPlay: (controller) => controller.repeat())
                            .shimmer(duration: 4500.ms, color: Color.fromARGB(255, 255, 179, 156)),
                          const SizedBox(height: 30),
                          const Text(
                            "Nos Valeurs",
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _ToggleTextContainer(),
                          const SizedBox(height: 60),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
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

class _ToggleTextContainer extends StatefulWidget {
  @override
  __ToggleTextContainerState createState() => __ToggleTextContainerState();
}

class __ToggleTextContainerState extends State<_ToggleTextContainer> {
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
      child: Container(
        height: 300,
        width: 180,
        color: const Color.fromARGB(255, 31, 31, 31),
        child: Center(
          child: Text(
            _isFirstTextVisible
                ? "Savoir-être\nSavoir-faire"
                : "Le professionnalisme et la qualité du travail effectué par les équipes LETAFF sur le terrain font partie de nos caractéristiques maîtresses",
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
