import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import 'screens/home_shell.dart';
import 'state/app_state.dart';
import 'theme/app_theme.dart';

class ArtifactApp extends StatelessWidget {
  const ArtifactApp({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return MaterialApp(
      title: 'Taskflow',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: state.themeMode,
      locale: state.locale,
      supportedLocales: const [Locale('en'), Locale('ar')],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      home: const HomeShell(),
    );
  }
}
