import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class TFLiteHelper {
  static Interpreter? _interpreter;
  static List<String> _labels = [];
  static const int _inputSize = 224;
  static const int _numChannels = 3;

  static bool get isLoaded => _interpreter != null;

  static Future<void> loadModel() async {
    if (_interpreter != null) {
      print("Interpreter already loaded.");
      return;
    }

    try {
      _interpreter = await Interpreter.fromAsset('assets/model/model.tflite');
      final labelData = await rootBundle.loadString('assets/model/labels.txt');
      _labels = labelData
          .split('\n')
          .where((label) => label.trim().isNotEmpty)
          .toList();
      print("Model and labels loaded successfully.");
    } catch (e) {
      print("Failed to load model or labels: $e");
      rethrow; // Rethrow to let calling code handle the failure if needed
    }
  }

  static Future<String> runModelOnImage(String imagePath) async {
    if (_interpreter == null) {
      throw Exception("Interpreter not loaded. Call loadModel() first.");
    }

    try {
      final imageFile = File(imagePath);
      if (!await imageFile.exists()) {
        throw Exception("Image file not found at path: $imagePath");
      }

      final rawBytes = await imageFile.readAsBytes();
      final rawImage = img.decodeImage(rawBytes);
      if (rawImage == null) {
        throw Exception("Failed to decode image");
      }

      final resizedImage =
          img.copyResize(rawImage, width: _inputSize, height: _inputSize);
      final input = _imageToByteListFloat32(resizedImage);

      final output = List.filled(_labels.length, 0.0).reshape([1, _labels.length]);
      _interpreter!.run(input, output);

      final scores = List<double>.from(output[0]);
      final maxScore = scores.reduce((a, b) => a > b ? a : b);
      final predictedIndex = scores.indexOf(maxScore);

      return _labels[predictedIndex];
    } catch (e) {
      print("Model inference failed: $e");
      rethrow;
    }
  }

  static Uint8List _imageToByteListFloat32(img.Image image) {
    final Float32List floatList = Float32List(_inputSize * _inputSize * _numChannels);
    int index = 0;

    for (int y = 0; y < _inputSize; y++) {
      for (int x = 0; x < _inputSize; x++) {
        final pixel = image.getPixel(x, y);
        floatList[index++] = pixel.r / 255.0;
        floatList[index++] = pixel.g / 255.0;
        floatList[index++] = pixel.b / 255.0;
      }
    }

    return floatList.buffer.asUint8List();
  }

  static void dispose() {
    _interpreter?.close();
    _interpreter = null;
    _labels.clear();
    print("Interpreter and labels disposed.");
  }
}
