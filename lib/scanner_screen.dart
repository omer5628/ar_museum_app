import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class ScannerScreen extends StatefulWidget {
  final VoidCallback onBack;

  const ScannerScreen({Key? key, required this.onBack}) : super(key: key);

  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _isBusy = false;
  File? _capturedImage;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final backCam = cameras.firstWhere((cam) => cam.lensDirection == CameraLensDirection.back);
    _controller = CameraController(backCam, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    if (_isBusy) return;

    try {
      setState(() => _isBusy = true);
      await _initializeControllerFuture;

      final tempDir = await getTemporaryDirectory();
      final filePath = p.join(tempDir.path, '${DateTime.now().millisecondsSinceEpoch}.jpg');

      XFile picture = await _controller.takePicture();
      final imageFile = File(picture.path);

      setState(() {
        _capturedImage = imageFile;
      });
    } catch (e) {
      print('Error taking picture: $e');
    } finally {
      setState(() => _isBusy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanner'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
      ),
      body: FutureBuilder(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return _capturedImage == null
                ? Stack(
                    children: [
                      CameraPreview(_controller),
                      Positioned(
                        bottom: 20,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: ElevatedButton(
                            onPressed: _isBusy ? null : _takePicture,
                            child: _isBusy
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text('Take Picture'),
                          ),
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.file(_capturedImage!),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            setState(() => _capturedImage = null);
                          },
                          child: Text('Retake'),
                        ),
                        ElevatedButton(
                          onPressed: widget.onBack,
                          child: Text('Back to Main'),
                        ),
                      ],
                    ),
                  );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
