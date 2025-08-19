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

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.asset('assets/videos/intro.mp4')
          ..setLooping(true)
          ..initialize().then((_) {
            setState(() {});
            _controller.setVolume(1.0);
            _controller.play();
          });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final progressColors = VideoProgressColors(
      playedColor: Colors.purpleAccent,
      backgroundColor: Colors.white24,
      bufferedColor: Colors.white38,
    );

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Pre Tour'),
        leading: BackButton(onPressed: widget.onBack),
      ),
      body: Center(
        child:
            _controller.value.isInitialized
                ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play();
                    });
                  },
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                )
                : const CircularProgressIndicator(),
      ),

      // ⬇️ שורת ההתקדמות ירדה לכאן, עטופה ב-SafeArea כדי לא להיחתך ע"י פס המערכת
      bottomNavigationBar:
          _controller.value.isInitialized
              ? SafeArea(
                minimum: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 12,
                  top: 8,
                ),
                child: Row(
                  children: [
                    Text(
                      _formatDuration(_controller.value.position),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: VideoProgressIndicator(
                        _controller,
                        allowScrubbing: true,
                        colors: progressColors,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _formatDuration(_controller.value.duration),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              )
              : null,
    );
  }
}
