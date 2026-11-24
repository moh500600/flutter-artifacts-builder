import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import '../strings.dart';
import '../theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = Strings.of(context);
    final scheme = Theme.of(context).colorScheme;
    final state = context.watch<AppState>();

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(AppTheme.spaceLg),
        children: [
          Text(
            strings.tabSettings,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: scheme.onSurface,
            ),
          ),
          const SizedBox(height: AppTheme.spaceXl),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  secondary: const Icon(Icons.dark_mode_outlined),
                  title: Text(strings.darkMode),
                  value: state.themeMode == ThemeMode.dark,
                  onChanged: (_) => state.toggleTheme(),
                ),
                const Divider(height: 1, indent: 16, endIndent: 16),
                SwitchListTile(
                  secondary: const Icon(Icons.translate),
                  title: Text(strings.arabicLocale),
                  value: state.locale.languageCode == 'ar',
                  onChanged: (_) => state.toggleLocale(),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppTheme.spaceLg),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.spaceLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    strings.aboutTitle,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: scheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spaceSm),
                  Text(
                    strings.aboutBody,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.5,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
