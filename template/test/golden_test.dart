import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:__PROJECT_NAME__/app.dart';
import 'package:__PROJECT_NAME__/state/app_state.dart';

import 'test_fonts.dart';

void main() {
  setUpAll(loadAppFonts);

  Future<WidgetTester> pumpAtPhoneSize(
    WidgetTester tester,
    AppState state,
  ) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      ChangeNotifierProvider<AppState>.value(
        value: state,
        child: const ArtifactApp(),
      ),
    );
    await tester.pumpAndSettle();
    return tester;
  }

  testWidgets('golden: home, English, light', (tester) async {
    await pumpAtPhoneSize(tester, AppState());
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('goldens/home_en_light.png'),
    );
  });

  testWidgets('golden: home, English, dark', (tester) async {
    final state = AppState()..toggleTheme();
    await pumpAtPhoneSize(tester, state);
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('goldens/home_en_dark.png'),
    );
  });

  testWidgets('golden: home, Arabic RTL, light', (tester) async {
    final state = AppState()..toggleLocale();
    await pumpAtPhoneSize(tester, state);
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('goldens/home_ar_light.png'),
    );
  });

  testWidgets('golden: settings, English, light', (tester) async {
    await pumpAtPhoneSize(tester, AppState());
    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('goldens/settings_en_light.png'),
    );
  });

  testWidgets('golden: home, English, tablet size', (tester) async {
    tester.view.physicalSize = const Size(1600, 2560);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      ChangeNotifierProvider<AppState>.value(
        value: AppState(),
        child: const ArtifactApp(),
      ),
    );
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('goldens/home_en_tablet.png'),
    );
  });
}
