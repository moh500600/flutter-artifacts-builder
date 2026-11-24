import 'package:material_ui/material_ui.dart';

/// Application state shared across screens. Extend this class (or swap in
/// riverpod/bloc for larger apps) - keep business logic out of widgets.
class AppState extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = const Locale('en');
  final Set<String> _completedTaskIds = <String>{};

  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;
  int get completedCount => _completedTaskIds.length;

  bool isCompleted(String taskId) => _completedTaskIds.contains(taskId);

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  void toggleLocale() {
    _locale = _locale.languageCode == 'ar'
        ? const Locale('en')
        : const Locale('ar');
    notifyListeners();
  }

  void toggleTask(String taskId) {
    if (!_completedTaskIds.remove(taskId)) {
      _completedTaskIds.add(taskId);
    }
    notifyListeners();
  }
}
