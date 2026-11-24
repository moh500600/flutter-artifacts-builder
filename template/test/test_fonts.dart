import 'dart:io';

import 'package:flutter/services.dart';

/// Loads the bundled Tajawal fonts and the Material Icons font so golden
/// screenshots render real typography and icons instead of test-font boxes.
Future<void> loadAppFonts() async {
  final tajawal = FontLoader('Tajawal');
  for (final file in const [
    'Tajawal-Regular.ttf',
    'Tajawal-Medium.ttf',
    'Tajawal-Bold.ttf',
    'Tajawal-ExtraBold.ttf',
  ]) {
    final bytes = File('assets/fonts/$file').readAsBytesSync();
    tajawal.addFont(Future<ByteData>.value(ByteData.sublistView(bytes)));
  }
  await tajawal.load();

  // The Material Icons font ships with the Flutter SDK, not with the
  // material_ui package, so load it from FLUTTER_ROOT when available.
  final flutterRoot = Platform.environment['FLUTTER_ROOT'];
  if (flutterRoot == null) {
    return;
  }
  final icons = File(
    '$flutterRoot/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf',
  );
  if (icons.existsSync()) {
    final loader = FontLoader('MaterialIcons')
      ..addFont(
        Future<ByteData>.value(ByteData.sublistView(icons.readAsBytesSync())),
      );
    await loader.load();
  }
}
