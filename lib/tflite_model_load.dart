import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class ExhibitClassifier {
  late Interpreter _interpreter;
  late List<String> _labels;

  final int inputSize = 224; // Adjust based on your model

  ExhibitClassifier() {
    _loadModel();
    _loadLabels();
  }

  Future<void> _loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('model/exhibits_classifier.tflite');
      print("Model loaded");
    } catch (e) {
      print("Failed to load model: $e");
    }
  }

  Future<void> _loadLabels() async {
    try {
      final labelData = await rootBundle.loadString('assets/model/labels.txt');
      _labels = labelData.split('\n');
      print("Labels loaded");
    } catch (e) {
      print("Failed to load labels: $e");
      _labels = [];
    }
  }

  Uint8List _preprocessImage(File imageFile) {
  final rawImage = img.decodeImage(imageFile.readAsBytesSync())!;
  final resized = img.copyResize(rawImage, width: inputSize, height: inputSize);

  final floatBuffer = Float32List(inputSize * inputSize * 3);
  int index = 0;

  for (int y = 0; y < inputSize; y++) {
    for (int x = 0; x < inputSize; x++) {
      final pixel = resized.getPixel(x, y); // returns Color object in img 4.x+
      floatBuffer[index++] = pixel.r / 255.0;
      floatBuffer[index++] = pixel.g / 255.0;
      floatBuffer[index++] = pixel.b / 255.0;
    }
  }

  return floatBuffer.buffer.asUint8List();
}

  Future<String> classify(File imageFile) async {
    final inputBytes = _preprocessImage(imageFile);
    final inputTensor = Float32List.view(inputBytes.buffer);

    final outputShape = _interpreter.getOutputTensor(0).shape;
    final output = List.filled(outputShape[1], 0.0).reshape([1, outputShape[1]]);

    _interpreter.run([inputTensor], output);

    final prediction = output[0] as List<double>;
    int maxIndex = prediction.indexWhere((e) => e == prediction.reduce((a, b) => a > b ? a : b));

    return _labels.isNotEmpty ? _labels[maxIndex] : "Class #$maxIndex";
  }
}
