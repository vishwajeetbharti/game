import 'dart:math';
import '../domain/entities.dart';

class NumberGenerator {
  final Random _rng = Random();

  List<Cell> bootstrap(LevelConfig level) {
    final cells = <Cell>[];
    for (int r = 0; r < level.rows; r++) {
      for (int c = 0; c < level.cols; c++) {
        final idx = r * level.cols + c;
        final bool shouldFill = r >= (level.rows - level.initialFilledRows); // fill bottom 3-4 rows only
        final int? value = shouldFill ? LevelPresets.randomAllowed(level.allowedNumbers, _rng) : null;
        cells.add(Cell(index: idx, row: r, col: c, value: value));
      }
    }
    return cells;
  }

  List<Cell> addRow(LevelConfig level, List<Cell> current) {
    final List<Cell> next = List.from(current);
    int targetRow = -1;
    for (int r = level.rows - 1; r >= 0; r--) {
      final rowValues = next.where((c) => c.row == r).toList();
      final isEmptyRow = rowValues.every((c) => c.value == null);
      if (isEmptyRow) {
        targetRow = r;
        break;
      }
    }
    if (targetRow == -1) {
      for (int r = 0; r < level.rows; r++) {
        final rowValues = next.where((c) => c.row == r).toList();
        final hasNull = rowValues.any((c) => c.value == null);
        if (hasNull) {
          targetRow = r;
          break;
        }
      }
    }
    if (targetRow == -1) {
      return next;
    }

    for (int c = 0; c < level.cols; c++) {
      final idx = targetRow * level.cols + c;
      final old = next[idx];
      next[idx] = old.copyWith(value: LevelPresets.randomAllowed(level.allowedNumbers, _rng), matched: false);
    }
    return next;
  }
}
