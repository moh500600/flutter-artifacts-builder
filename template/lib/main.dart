import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'state/app_state.dart';

void main() {
  runApp(
    ChangeNotifierProvider<AppState>(
      create: (_) => AppState(),
      child: const ArtifactApp(),
    ),
  );
}
