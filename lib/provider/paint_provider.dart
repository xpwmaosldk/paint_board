import 'dart:math';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class PaintProvider extends ChangeNotifier {
  final lines = <List<Offset>>[];
  final linesHistory = <List<Offset>>[];
  final GlobalKey captureKey = GlobalKey();
  bool outOfRange = false;
  Uint8List? backgroundImageData;

  bool _eraseMode = false;
  bool get eraseMode => _eraseMode;

  void changeEraseMode() {
    _eraseMode = !_eraseMode;
    notifyListeners();
  }

  void drawStart(Offset offset) {
    var oneLine = <Offset>[];
    oneLine.add(offset);
    lines.add(oneLine);
    notifyListeners();
  }

  void drawing(Offset offset) {
    lines.last.add(offset);
    notifyListeners();
  }

  void erase(Offset offset) {
    final eraseGap = 15;
    for (var oneLine in lines) {
      for (var offsetOnLine in oneLine) {
        if (sqrt(pow((offset.dx - offsetOnLine.dx), 2) +
                pow((offset.dy - offsetOnLine.dy), 2)) <
            eraseGap) {
          lines.remove(oneLine);
          break;
        }
      }
    }
    notifyListeners();
  }

  void save() async {
    print("START CAPTURE");
    var renderObject = captureKey.currentContext!.findRenderObject();

    if (renderObject is RenderRepaintBoundary) {
      ui.Image image = await renderObject.toImage();
      final directory = (await getExternalStorageDirectory())!.path;
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      print(pngBytes);
      File imgFile = File('$directory/screenshot.png');
      imgFile.writeAsBytesSync(pngBytes);
      print("FINISH CAPTURE ${imgFile.path}");
    }
  }

  void load() async {
    print('load');
    final PickedFile? pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    print(pickedFile?.path);
    backgroundImageData = await pickedFile!.readAsBytes();
    notifyListeners();
  }

  void back() {
    if (lines.isNotEmpty) {
      linesHistory.add(lines.removeLast());
      notifyListeners();
    }
  }

  void forward() {
    if (linesHistory.isNotEmpty) {
      lines.add(linesHistory.removeLast());
      notifyListeners();
    }
  }
}
