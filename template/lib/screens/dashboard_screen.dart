import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../models/sample_data.dart';
import '../state/app_state.dart';
import '../strings.dart';
import '../theme/app_theme.dart';
import '../widgets/stat_card.dart';
import '../widgets/task_tile.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = Strings.of(context);
    final scheme = Theme.of(context).colorScheme;
    final state = context.watch<AppState>();
    final completed = state.completedCount;
    final active = sampleTasks.length - completed;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(AppTheme.spaceLg),
        children: [
          Text(
            strings.greeting,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: scheme.onSurface,
            ),
          ),
          const SizedBox(height: AppTheme.spaceXs),
          Text(
            strings.daySummary,
            style: TextStyle(fontSize: 14, color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: AppTheme.spaceXl),
          Row(
            children: [
              Expanded(
                child: StatCard(
                  value: '$completed',
                  label: strings.statCompleted,
                  icon: Icons.check_circle_outline,
                  accent: scheme.primary,
                ),
              ),
              const SizedBox(width: AppTheme.spaceMd),
              Expanded(
                child: StatCard(
                  value: '$active',
                  label: strings.statActive,
                  icon: Icons.bolt_outlined,
                  accent: scheme.tertiary,
                ),
              ),
              const SizedBox(width: AppTheme.spaceMd),
              Expanded(
                child: StatCard(
                  value: '1',
                  label: strings.statOverdue,
                  icon: Icons.schedule,
                  accent: scheme.error,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spaceXl),
          Text(
            strings.sectionToday,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: scheme.onSurface,
            ),
          ),
          const SizedBox(height: AppTheme.spaceMd),
          for (final task in sampleTasks) ...[
            TaskTile(task: task),
            const SizedBox(height: AppTheme.spaceSm),
          ],
        ],
      ),
    );
  }
}
