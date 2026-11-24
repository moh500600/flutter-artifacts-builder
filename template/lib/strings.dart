import 'package:flutter/widgets.dart';

/// Minimal string table for the starter's two locales. For a real app,
/// graduate to the `intl` package and .arb files.
class Strings {
  const Strings._(this.isArabic);

  final bool isArabic;

  static Strings of(BuildContext context) {
    final code = Localizations.localeOf(context).languageCode;
    return Strings._(code == 'ar');
  }

  String get tabHome => isArabic ? 'الرئيسية' : 'Home';
  String get tabExplore => isArabic ? 'استكشاف' : 'Explore';
  String get tabSettings => isArabic ? 'الإعدادات' : 'Settings';

  String get greeting => isArabic ? 'صباح الخير' : 'Good morning';
  String get daySummary =>
      isArabic ? 'هذه نظرة على يومك' : 'Here is your day at a glance';

  String get statCompleted => isArabic ? 'مكتملة' : 'Completed';
  String get statActive => isArabic ? 'نشطة' : 'Active';
  String get statOverdue => isArabic ? 'متأخرة' : 'Overdue';

  String get sectionToday => isArabic ? 'أولويات اليوم' : "Today's priorities";
  String get sectionOverdue => isArabic ? 'متأخرة' : 'Needs attention';

  String get exploreTitle => isArabic ? 'تصفح الفئات' : 'Browse categories';
  String tasksCount(int count) => isArabic ? '$count مهمة' : '$count tasks';

  String get darkMode => isArabic ? 'الوضع الداكن' : 'Dark mode';
  String get arabicLocale => isArabic ? 'العربية (من اليمين)' : 'Arabic (RTL)';
  String get aboutTitle => isArabic ? 'حول هذا التطبيق' : 'About this app';
  String get aboutBody => isArabic
      ? 'نموذج أولي مبني بأداة flutter-artifacts-builder. عدّل الشاشات والبيانات لتناسب مشروعك.'
      : 'Starter artifact built with flutter-artifacts-builder. Edit the screens and sample data to make it yours.';

  String subtaskProgress(int done, int total) => '$done/$total';
}
