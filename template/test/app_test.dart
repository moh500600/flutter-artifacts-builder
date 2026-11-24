import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:__PROJECT_NAME__/app.dart';
import 'package:__PROJECT_NAME__/state/app_state.dart';

import 'test_fonts.dart';

void main() {
  setUpAll(loadAppFonts);

  Widget buildApp(AppState state) {
    return ChangeNotifierProvider<AppState>.value(
      value: state,
      child: const ArtifactApp(),
    );
  }

  testWidgets('dashboard renders greeting, stats and tasks', (tester) async {
    await tester.pumpWidget(buildApp(AppState()));
    await tester.pumpAndSettle();

    expect(find.text('Good morning'), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('Prepare release notes'), findsOneWidget);
    expect(find.text("Today's priorities"), findsOneWidget);
  });

  testWidgets('theme toggle switches theme mode', (tester) async {
    final state = AppState();
    await tester.pumpWidget(buildApp(state));

    expect(state.themeMode, ThemeMode.light);
    state.toggleTheme();
    expect(state.themeMode, ThemeMode.dark);
  });

  testWidgets('locale toggle switches strings to Arabic', (tester) async {
    final state = AppState();
    await tester.pumpWidget(buildApp(state));

    state.toggleLocale();
    await tester.pumpAndSettle();

    expect(find.text('صباح الخير'), findsOneWidget);
  });

  testWidgets('completing a task updates state', (tester) async {
    final state = AppState();
    await tester.pumpWidget(buildApp(state));

    expect(state.completedCount, 0);
    state.toggleTask('t1');
    expect(state.completedCount, 1);
    state.toggleTask('t1');
    expect(state.completedCount, 0);
  });

  testWidgets('every navigation destination switches screens', (tester) async {
    await tester.pumpWidget(buildApp(AppState()));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.explore_outlined));
    await tester.pumpAndSettle();
    expect(find.text('Browse categories'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle();
    expect(find.text('Dark mode'), findsOneWidget);
  });
}
