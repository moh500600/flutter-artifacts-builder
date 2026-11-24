import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:__PROJECT_NAME__/app.dart';
import 'package:__PROJECT_NAME__/state/app_state.dart';

import 'test_fonts.dart';

void main() {
  setUpAll(loadAppFonts);

  testWidgets('accessibility: controls expose labels and meet touch targets',
      (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      ChangeNotifierProvider<AppState>.value(
        value: AppState(),
        child: const ArtifactApp(),
      ),
    );
    await tester.pumpAndSettle();

    // Bottom navigation exposes labeled destinations (English default locale).
    expect(find.bySemanticsLabel(RegExp('Home')), findsWidgets);
    expect(find.bySemanticsLabel(RegExp('Explore')), findsWidgets);
    expect(find.bySemanticsLabel(RegExp('Settings')), findsWidgets);

    // Task completion toggles expose tooltips read by screen readers.
    expect(find.byTooltip('Complete'), findsWidgets);

    // Interactive controls meet the 48dp minimum touch target.
    final size = tester.getSize(find.byTooltip('Complete').first);
    expect(size.width, greaterThanOrEqualTo(48));
    expect(size.height, greaterThanOrEqualTo(48));
  });
}
