import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../models/sample_data.dart';
import '../state/app_state.dart';
import '../strings.dart';
import '../theme/app_theme.dart';

/// One task row: priority edge bar, title, meta line, progress and a
/// completion toggle. Uses BorderDirectional so the edge bar stays on the
/// leading side in RTL too.
class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task});

  final TaskItem task;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final strings = Strings.of(context);
    final state = context.watch<AppState>();
    final done = state.isCompleted(task.id);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          border: BorderDirectional(
            start: BorderSide(color: task.priority.color(scheme), width: 3),
          ),
        ),
        padding: const EdgeInsets.all(AppTheme.spaceMd),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title(strings.isArabic),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: done ? scheme.onSurfaceVariant : scheme.onSurface,
                      decoration: done ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spaceXs),
                  Text(
                    task.meta(strings.isArabic),
                    style: TextStyle(fontSize: 12, color: scheme.onSurfaceVariant),
                  ),
                  const SizedBox(height: AppTheme.spaceSm),
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: task.progress,
                          minHeight: 4,
                          borderRadius: BorderRadius.circular(2),
                          backgroundColor: scheme.surfaceContainerHighest,
                        ),
                      ),
                      const SizedBox(width: AppTheme.spaceSm),
                      Text(
                        strings.subtaskProgress(
                          task.subtasksDone,
                          task.subtasksTotal,
                        ),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppTheme.spaceSm),
            IconButton(
              tooltip: done ? 'Undo' : 'Complete',
              style: IconButton.styleFrom(
                minimumSize: const Size(48, 48),
                tapTargetSize: MaterialTapTargetSize.padded,
              ),
              onPressed: () => state.toggleTask(task.id),
              icon: Icon(
                done ? Icons.check_circle : Icons.radio_button_unchecked,
                color: done ? scheme.primary : scheme.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
