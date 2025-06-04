import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PreTourScreen extends StatefulWidget {
  const PreTourScreen({super.key, required this.onBack});
  final VoidCallback onBack;

  @override
  State<PreTourScreen> createState() => _PreTourScreenState();
}

class _PreTourScreenState extends State<PreTourScreen> {
  late VideoPlayerController _controller;
  bool _showControls = true; // להצגת Play/Pause קטנים

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/intro.mp4')
      ..initialize().then((_) => setState(() {}));
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Pre Tour'),
        leading: BackButton(onPressed: widget.onBack),
      ),
      body: Center(
        child:
            _controller.value.isInitialized
                ? Stack(
                  alignment: Alignment.center,
                  children: [
                    AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                    // כפתור Play / Pause שקוף
                    if (_showControls)
                      IconButton(
                        iconSize: 64,
                        color: Colors.white70,
                        icon: Icon(
                          _controller.value.isPlaying
                              ? Icons.pause_circle
                              : Icons.play_circle,
                        ),
                        onPressed: () {
                          setState(() {
                            _controller.value.isPlaying
                                ? _controller.pause()
                                : _controller.play();
                            _showControls = true;
                          });
                        },
                      ),
                    // הקשה על המסך מסתירה / מציגה כפתור
                    Positioned.fill(
                      child: GestureDetector(
                        onTap:
                            () =>
                                setState(() => _showControls = !_showControls),
                      ),
                    ),
                  ],
                )
                : const CircularProgressIndicator(),
      ),
    );
  }
}
