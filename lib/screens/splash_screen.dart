import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/intro_video.mp4')
      ..setVolume(1.0)
      ..initialize().then((_) {
        if (!mounted) return;
        setState(() {});
        _controller.play();
        _controller.setLooping(false);

        // Pasa a login cuando termine o a los 10 segundos
        Future.delayed(const Duration(seconds: 10), () {
          if (mounted) {
            Navigator.pushReplacementNamed(context, '/login');
          }
        });
      }).catchError((error) {
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/login');
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _controller.value.isInitialized
          ? Stack(
              fit: StackFit.expand,
              children: [
                FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller),
                  ),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF1A5F7A),
                strokeWidth: 6,
              ),
            ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
