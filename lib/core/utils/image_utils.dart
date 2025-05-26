import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

Future<XFile?> addMetadataToImage(
  String inputPath, {
  double? latitude,
  double? longitude,
}) async {
  try {
    final now = DateTime.now();
    final formattedDate =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
    final formattedTime =
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";

    final imageBytes = await File(inputPath).readAsBytes();
    final original = img.decodeImage(imageBytes);

    if (original == null) return null;

    final text =
        'Fecha: $formattedDate $formattedTime\nLatitud: $latitude\nLongitud: $longitude';

    final textLines = text.split('\n');
    final textHeight = textLines.length * 30;
    final boxPadding = 12;
    final boxWidth = original.width - 20;
    final boxHeight = textHeight + boxPadding * 2;
    final boxX = 10;
    final boxY = original.height - boxHeight - 10;

    img.fillRect(
      original,
      x1: boxX,
      y1: boxY,
      x2: boxX + boxWidth,
      y2: boxY + boxHeight,
      color: img.ColorRgb8(0, 0, 0),
    );

    int textY = boxY + boxPadding;
    for (final line in textLines) {
      img.drawString(
        original,
        line,
        font: img.arial24,
        x: boxX + boxPadding,
        y: textY,
        color: img.ColorRgb8(255, 255, 255),
      );
      textY += 30;
    }

    final dir = await getApplicationDocumentsDirectory();
    final newImagePath =
        '${dir.path}/image_metadata_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final newFile = File(newImagePath);
    await newFile.writeAsBytes(img.encodeJpg(original, quality: 85));

    try {
      await File(inputPath).delete();
      log('🗑 Imagen original eliminada: $inputPath');
    } catch (e) {
      log('⚠️ No se pudo eliminar la imagen original: $e');
    }

    return XFile(newImagePath);
  } catch (e, stack) {
    log('❌ Error al agregar metadatos: $e\n$stack');
    return null;
  }
}

Future<void> deleteImageByPath(String path) async {
  final file = File(path);
  if (await file.exists()) {
    try {
      await file.delete();
      print('🗑 Imagen eliminada: $path');
    } catch (e) {
      print('⚠️ Error al borrar imagen: $e');
    }
  }
}
