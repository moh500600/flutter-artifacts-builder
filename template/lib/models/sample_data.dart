import 'package:material_ui/material_ui.dart';

/// Replace this sample data with your real models and data sources.

enum TaskPriority { high, medium, low }

extension TaskPriorityColor on TaskPriority {
  Color color(ColorScheme scheme) => switch (this) {
        TaskPriority.high => scheme.error,
        TaskPriority.medium => scheme.tertiary,
        TaskPriority.low => scheme.outline,
      };
}

class TaskItem {
  const TaskItem({
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.metaEn,
    required this.metaAr,
    required this.priority,
    required this.progress,
    required this.subtasksDone,
    required this.subtasksTotal,
  });

  final String id;
  final String titleEn;
  final String titleAr;
  final String metaEn;
  final String metaAr;
  final TaskPriority priority;
  final double progress;
  final int subtasksDone;
  final int subtasksTotal;

  String title(bool isArabic) => isArabic ? titleAr : titleEn;
  String meta(bool isArabic) => isArabic ? metaAr : metaEn;
}

const sampleTasks = <TaskItem>[
  TaskItem(
    id: 't1',
    titleEn: 'Prepare release notes',
    titleAr: 'تجهيز ملاحظات الإصدار',
    metaEn: 'Today, 4:00 PM',
    metaAr: 'اليوم، 4:00 م',
    priority: TaskPriority.high,
    progress: 0.6,
    subtasksDone: 3,
    subtasksTotal: 5,
  ),
  TaskItem(
    id: 't2',
    titleEn: 'Fix invoice PDF layout',
    titleAr: 'إصلاح تنسيق PDF الفاتورة',
    metaEn: 'Overdue by 2 days',
    metaAr: 'متأخرة منذ يومين',
    priority: TaskPriority.high,
    progress: 0.8,
    subtasksDone: 4,
    subtasksTotal: 5,
  ),
  TaskItem(
    id: 't3',
    titleEn: 'Review pull requests',
    titleAr: 'مراجعة طلبات السحب',
    metaEn: 'Today, 6:30 PM',
    metaAr: 'اليوم، 6:30 م',
    priority: TaskPriority.medium,
    progress: 0.25,
    subtasksDone: 1,
    subtasksTotal: 4,
  ),
  TaskItem(
    id: 't4',
    titleEn: 'Update onboarding screens',
    titleAr: 'تحديث شاشات التهيئة',
    metaEn: 'Tomorrow, 10:00 AM',
    metaAr: 'غدًا، 10:00 ص',
    priority: TaskPriority.low,
    progress: 0,
    subtasksDone: 0,
    subtasksTotal: 3,
  ),
  TaskItem(
    id: 't5',
    titleEn: 'Write tests for the cart',
    titleAr: 'كتابة اختبارات للسلة',
    metaEn: 'This week',
    metaAr: 'هذا الأسبوع',
    priority: TaskPriority.medium,
    progress: 0.5,
    subtasksDone: 2,
    subtasksTotal: 4,
  ),
];

class Category {
  const Category({
    required this.icon,
    required this.nameEn,
    required this.nameAr,
    required this.count,
  });

  final IconData icon;
  final String nameEn;
  final String nameAr;
  final int count;

  String name(bool isArabic) => isArabic ? nameAr : nameEn;
}

const sampleCategories = <Category>[
  Category(icon: Icons.work_outline, nameEn: 'Work', nameAr: 'العمل', count: 12),
  Category(icon: Icons.person_outline, nameEn: 'Personal', nameAr: 'شخصي', count: 7),
  Category(icon: Icons.shopping_cart_outlined, nameEn: 'Shopping', nameAr: 'تسوق', count: 5),
  Category(icon: Icons.favorite_outline, nameEn: 'Health', nameAr: 'الصحة', count: 3),
  Category(icon: Icons.school_outlined, nameEn: 'Learning', nameAr: 'التعلم', count: 9),
  Category(icon: Icons.flight_outlined, nameEn: 'Travel', nameAr: 'السفر', count: 2),
];
