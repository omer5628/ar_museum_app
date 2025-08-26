import 'dart:io';
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
      _debugPrintModelIO();
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

    final resizedImage = img.copyResize(rawImage, width: _inputSize, height: _inputSize);

    final input = _imageToInputRaw255(resizedImage);

    final output = List.generate(1, (_) => List.filled(_labels.length, 0.0));
    _interpreter!.run(input, output);

    final scores = List<double>.from(output[0]);
    final maxScore = scores.reduce((a, b) => a > b ? a : b);
    final predictedIndex = scores.indexOf(maxScore);
    if (maxScore < 0.57) { // כאן
      return "Unknown";
    }
    return _labels[predictedIndex];
  } catch (e) {
    print("Model inference failed: $e");
    rethrow;
  }
}


  // 1) Replace your builder with RAW (0..255) input — no normalization
    static List _imageToInputRaw255(img.Image image) {
      final input = List.generate(1, (_) =>
          List.generate(_inputSize, (_) =>
              List.generate(_inputSize, (_) => List.filled(_numChannels, 0.0))));

      for (int y = 0; y < _inputSize; y++) {
        for (int x = 0; x < _inputSize; x++) {
          final p = image.getPixel(x, y);
          input[0][y][x][0] = p.r.toDouble(); 
          input[0][y][x][1] = p.g.toDouble();
          input[0][y][x][2] = p.b.toDouble();
        }
      }
      return input;
    }

    // 2) (Optional but recommended) After loading, verify IO matches labels
    static void _debugPrintModelIO() {
      final it = _interpreter!;
      final inT = it.getInputTensor(0);
      final outT = it.getOutputTensor(0);
      print('TFLite input  : shape=${inT.shape} type=${inT.type}');
      print('TFLite output : shape=${outT.shape} type=${outT.type}');
      if (outT.shape.last != _labels.length) {
        throw Exception('Labels (${_labels.length}) != model outputs (${outT.shape.last})');
      }
    }

}
