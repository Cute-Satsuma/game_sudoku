import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../l10n/app_localizations.dart';
import '../services/campaign_progress.dart';
import '../services/game_settings_controller.dart';
import '../sudoku/hint_candidates.dart';
import '../sudoku/sudoku_generator.dart';
import '../sudoku/sudoku_validator.dart';
import '../theme/hero_background.dart';
import '../widgets/hint_accents.dart';
import '../widgets/number_pad.dart';
import '../widgets/quick_number_pad.dart';
import '../widgets/sudoku_grid.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key, this.campaignMode, this.campaignLevel});

  /// Campaign mode: 1=Easy, 2=Medium, 3=Hard
  final int? campaignMode;

  /// Campaign level: 1-999
  final int? campaignLevel;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<List<int>> _grid = List.generate(9, (_) => List.filled(9, 0));
  List<List<int>> _initialPuzzle = List.generate(9, (_) => List.filled(9, 0));
  List<List<int>> _solution = List.generate(9, (_) => List.filled(9, 0));
  ({int row, int col})? _selectedCell;
  bool _isNotesMode = false;
  bool _isAutoFillMode = false;
  bool _quickPadVisible = false;
  final GlobalKey _selectedCellKey = GlobalKey();
  final GlobalKey _boardKey = GlobalKey();
  Set<({int row, int col})> _errorCells = {};
  List<List<Set<int>>> _notes = List.generate(
    9,
    (_) => List.generate(9, (_) => <int>{}),
  );
  int _difficulty = 2; // 1=Easy, 2=Medium, 3=Hard (Free Play)
  int _elapsedSeconds = 0;
  Timer? _timer;
  bool _isCompleted = false;

  bool get _isCampaign =>
      widget.campaignMode != null && widget.campaignLevel != null;
  bool _isLoading = true;
  int _errorCount = 0;
  static const int _maxErrors = 10; // Campaign error limit
  bool _isGameOver = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _newGame();
      if (mounted) {
        setState(() => _isLoading = false);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _newGame() {
    _timer?.cancel();
    _timer = null;
    _elapsedSeconds = 0;
    _isCompleted = false;
    _errorCount = 0;
    _isGameOver = false;

    final generator = SudokuGenerator();
    final result = _isCampaign
        ? generator.generateForLevel(
            mode: widget.campaignMode!,
            level: widget.campaignLevel!,
          )
        : generator.generatePuzzleWithSolution(difficulty: _difficulty);
    _initialPuzzle = result.puzzle;
    _solution = result.solution;
    _grid = _initialPuzzle.map((row) => List<int>.from(row)).toList();
    _selectedCell = null;
    _quickPadVisible = false;
    _errorCells = {};
    _isNotesMode = false;
    _isAutoFillMode = false;
    _notes = List.generate(9, (_) => List.generate(9, (_) => <int>{}));

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!_isCompleted) {
        setState(() => _elapsedSeconds++);
      }
    });
  }

  bool _isCellLocked(int row, int col) {
    if (_initialPuzzle[row][col] != 0) return true;
    final value = _grid[row][col];
    return value != 0 && value == _solution[row][col];
  }

  void _onCellTap(int row, int col) {
    if (_isCellLocked(row, col)) return;
    if (_isCampaign && _isGameOver) return;

    if (_isAutoFillMode) {
      setState(() {
        _quickPadVisible = false;
        _placeNumber(row, col, _solution[row][col]);
      });
      return;
    }

    final isSameCell = _selectedCell?.row == row && _selectedCell?.col == col;

    setState(() {
      if (isSameCell) {
        // Second tap on the selected cell opens the quick pad (if enabled).
        final quickPadEnabled = GameSettingsScope.of(
          context,
        ).quickNumberPadEnabled;
        if (quickPadEnabled) {
          _quickPadVisible = true;
        }
      } else {
        _selectedCell = (row: row, col: col);
        _quickPadVisible = false;
      }
    });
  }

  void _hideQuickPad() {
    if (!_quickPadVisible) return;
    setState(() => _quickPadVisible = false);
  }

  void _onQuickPadNumberTap(int number) {
    _onNumberTap(number);
    // Keep open in notes mode so multiple notes can be toggled quickly.
    if (!_isNotesMode && _quickPadVisible) {
      setState(() => _quickPadVisible = false);
    }
  }

  void _onNumberTap(int number) {
    if (_selectedCell == null) return;
    if (_isCampaign && _isGameOver) return;

    final (row: row, col: col) = _selectedCell!;
    if (_isCellLocked(row, col)) return;

    if (_isNotesMode) {
      if (_grid[row][col] != 0) return;
      setState(() {
        final next = {..._notes[row][col]};
        if (!next.add(number)) next.remove(number);
        _notes[row][col] = next;
      });
      return;
    }

    setState(() => _placeNumber(row, col, number));
  }

  void _placeNumber(int row, int col, int number) {
    _grid[row][col] = number;
    _notes[row][col] = {};
    _checkAndUpdateFeedback(row, col, number);
    if (number == _solution[row][col]) {
      _selectedCell = null;
      _quickPadVisible = false;
    }
    if (SudokuValidator.isComplete(_grid)) {
      _isCompleted = true;
      _timer?.cancel();
      _showWinDialog();
    }
  }

  /// Check if input is correct against solution, update error highlights
  void _checkAndUpdateFeedback(int row, int col, int number) {
    final isCorrect = number == _solution[row][col];
    if (isCorrect) {
      _errorCells = _errorCells.difference({(row: row, col: col)});
    } else {
      _errorCells = {..._errorCells, (row: row, col: col)};
      _errorCount++;
      if (_isCampaign) {
        if (_errorCount >= _maxErrors) {
          _isGameOver = true;
          _timer?.cancel();
          _showGameOverDialog();
        }
      }
    }
  }

  void _onClear() {
    if (_selectedCell == null) return;
    if (_isCampaign && _isGameOver) return;

    final (row: row, col: col) = _selectedCell!;
    if (_isCellLocked(row, col)) return;

    setState(() {
      _grid[row][col] = 0;
      _notes[row][col] = {};
      _errorCells = _errorCells.difference({(row: row, col: col)});
    });
  }

  void _onNotes() {
    setState(() {
      _isNotesMode = !_isNotesMode;
      if (_isNotesMode) _isAutoFillMode = false;
    });
  }

  void _onAutoFill() {
    if (_isAutoFillMode) {
      setState(() => _isAutoFillMode = false);
      return;
    }
    if (_selectedCell == null) return;
    if (_isCampaign && _isGameOver) return;

    final (row: row, col: col) = _selectedCell!;
    if (_isCellLocked(row, col)) return;

    setState(() => _placeNumber(row, col, _solution[row][col]));
  }

  void _onAutoFillLongPress() {
    if (_isCampaign && _isGameOver) return;
    HapticFeedback.lightImpact();
    setState(() {
      _isAutoFillMode = !_isAutoFillMode;
      if (_isAutoFillMode) {
        _isNotesMode = false;
        _selectedCell = null;
        _quickPadVisible = false;
      }
    });
  }

  void _showGameOverDialog() {
    if (!mounted) return;
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.gameOver),
        content: Text(
          l10n.gameOverDescFormatted(_maxErrors, _formatTime(_elapsedSeconds)),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context, true);
            },
            child: Text(l10n.back),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              _newGame();
              setState(() {});
            },
            child: Text(l10n.retry),
          ),
        ],
      ),
    );
  }

  void _showWinDialog() async {
    if (_isCampaign) {
      await CampaignProgress.unlockNextLevel(
        widget.campaignMode!,
        widget.campaignLevel!,
      );
    }

    if (!mounted) return;
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.congrats),
        content: Text(l10n.congratsDescFormatted(_formatTime(_elapsedSeconds))),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              if (_isCampaign) {
                Navigator.pop(context, true);
              }
            },
            child: Text(l10n.confirm),
          ),
          if (_isCampaign && widget.campaignLevel! < 999)
            FilledButton(
              onPressed: () {
                Navigator.pop(ctx);
                Navigator.pop(context, widget.campaignLevel! + 1);
              },
              child: Text(l10n.nextLevel),
            )
          else if (!_isCampaign)
            FilledButton(
              onPressed: () {
                Navigator.pop(ctx);
                _newGame();
              },
              child: Text(l10n.newGame),
            ),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  void _showDifficultyDialog() {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.selectDifficulty),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(l10n.difficultyEasy),
              leading: Icon(
                _difficulty == 1
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
              ),
              onTap: () {
                _difficulty = 1;
                Navigator.pop(ctx);
                _newGame();
                setState(() {});
              },
            ),
            ListTile(
              title: Text(l10n.difficultyMedium),
              leading: Icon(
                _difficulty == 2
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
              ),
              onTap: () {
                _difficulty = 2;
                Navigator.pop(ctx);
                _newGame();
                setState(() {});
              },
            ),
            ListTile(
              title: Text(l10n.difficultyHard),
              leading: Icon(
                _difficulty == 3
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
              ),
              onTap: () {
                _difficulty = 3;
                Navigator.pop(ctx);
                _newGame();
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }

  CellHintCandidates _visibleHints(GameSettingsController settings) {
    final cell = _selectedCell;
    if (cell == null || !settings.anyHintEnabled) {
      return CellHintCandidates.empty;
    }
    final raw = HintCandidates.forCell(_grid, cell.row, cell.col);
    return CellHintCandidates(
      box: settings.hintBoxEnabled ? raw.box : const <int>{},
      column: settings.hintColumnEnabled ? raw.column : const <int>{},
      row: settings.hintRowEnabled ? raw.row : const <int>{},
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final onHero = cajuOnHeroForeground(context);
    final gameSettings = GameSettingsScope.of(context);
    final hints = _visibleHints(gameSettings);
    final l10n = AppLocalizations.of(context);
    return Container(
      decoration: cajuHeroDecoration(context),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            _isCampaign
                ? AppLocalizations.of(context).level(widget.campaignLevel!)
                : AppLocalizations.of(context).sudoku,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          foregroundColor: onHero,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _newGame,
              tooltip: _isCampaign
                  ? AppLocalizations.of(context).replayLevel
                  : AppLocalizations.of(context).newGame,
            ),
            if (!_isCampaign)
              IconButton(
                icon: _DifficultyIcon(level: _difficulty),
                onPressed: _showDifficultyDialog,
                tooltip: AppLocalizations.of(context).difficulty,
              ),
          ],
        ),
        body: SafeArea(
          child: _isLoading
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: colorScheme.primary),
                      const SizedBox(height: 16),
                      Text(
                        AppLocalizations.of(context).loading,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          LayoutBuilder(
                            builder: (context, constraints) {
                              return SingleChildScrollView(
                                padding: const EdgeInsets.all(16),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minHeight: constraints.maxHeight - 32,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 2,
                                          right: 2,
                                          bottom: 10,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            _GameStatusBadge(
                                              icon: Icons.schedule_rounded,
                                              value: _formatTime(
                                                _elapsedSeconds,
                                              ),
                                              accentColor: colorScheme.primary,
                                            ),
                                            const Spacer(),
                                            _GameStatusBadge(
                                              icon: Icons.close_rounded,
                                              value: _isCampaign
                                                  ? '$_errorCount/$_maxErrors'
                                                  : '$_errorCount/∞',
                                              accentColor: _errorCount > 0
                                                  ? colorScheme.error
                                                  : colorScheme
                                                        .onSurfaceVariant,
                                              isAlert: _errorCount > 0,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SudokuGrid(
                                        key: _boardKey,
                                        grid: _grid,
                                        initialPuzzle: _initialPuzzle,
                                        selectedCell: _selectedCell,
                                        selectedCellKey: _selectedCellKey,
                                        onCellTap: _onCellTap,
                                        errorCells: _errorCells,
                                        notes: _notes,
                                      ),
                                      const SizedBox(height: 24),
                                      NumberPad(
                                        onNumberTap: _onNumberTap,
                                        onClear: _onClear,
                                        onNotes: _onNotes,
                                        onAutoFill: _onAutoFill,
                                        onAutoFillLongPress:
                                            _onAutoFillLongPress,
                                        isNotesMode: _isNotesMode,
                                        isAutoFillMode: _isAutoFillMode,
                                        notedNumbers:
                                            _isNotesMode &&
                                                _selectedCell != null
                                            ? _notes[_selectedCell!
                                                  .row][_selectedCell!.col]
                                            : const {},
                                        hintBoxNumbers: hints.box,
                                        hintColumnNumbers: hints.column,
                                        hintRowNumbers: hints.row,
                                        enabled: !(_isCampaign && _isGameOver),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          if (_quickPadVisible &&
                              _selectedCell != null &&
                              gameSettings.quickNumberPadEnabled)
                            Positioned.fill(
                              child: _QuickPadOverlay(
                                cellKey: _selectedCellKey,
                                boardKey: _boardKey,
                                cellRow: _selectedCell!.row,
                                onDismiss: _hideQuickPad,
                                onNumberTap: _onQuickPadNumberTap,
                                highlightedNumbers:
                                    _isNotesMode && _selectedCell != null
                                    ? _notes[_selectedCell!.row][_selectedCell!
                                          .col]
                                    : const {},
                                hintBoxNumbers: hints.box,
                                hintColumnNumbers: hints.column,
                                hintRowNumbers: hints.row,
                              ),
                            ),
                        ],
                      ),
                    ),
                    HintLegend(
                      boxEnabled: gameSettings.hintBoxEnabled,
                      columnEnabled: gameSettings.hintColumnEnabled,
                      rowEnabled: gameSettings.hintRowEnabled,
                      boxLabel: l10n.hintLegendBox,
                      columnLabel: l10n.hintLegendColumn,
                      rowLabel: l10n.hintLegendRow,
                      onTap: () => showHintModesDialog(context),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _QuickPadOverlay extends StatefulWidget {
  const _QuickPadOverlay({
    required this.cellKey,
    required this.boardKey,
    required this.cellRow,
    required this.onDismiss,
    required this.onNumberTap,
    this.highlightedNumbers = const {},
    this.hintBoxNumbers = const {},
    this.hintColumnNumbers = const {},
    this.hintRowNumbers = const {},
  });

  final GlobalKey cellKey;
  final GlobalKey boardKey;
  final int cellRow;
  final VoidCallback onDismiss;
  final void Function(int number) onNumberTap;
  final Set<int> highlightedNumbers;
  final Set<int> hintBoxNumbers;
  final Set<int> hintColumnNumbers;
  final Set<int> hintRowNumbers;

  @override
  State<_QuickPadOverlay> createState() => _QuickPadOverlayState();
}

class _QuickPadOverlayState extends State<_QuickPadOverlay> {
  Offset? _topLeft;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _updatePosition());
  }

  @override
  void didUpdateWidget(covariant _QuickPadOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) => _updatePosition());
  }

  void _updatePosition() {
    if (!mounted) return;
    final cellBox =
        widget.cellKey.currentContext?.findRenderObject() as RenderBox?;
    final boardBox =
        widget.boardKey.currentContext?.findRenderObject() as RenderBox?;
    final overlayBox = context.findRenderObject() as RenderBox?;
    if (cellBox == null ||
        boardBox == null ||
        overlayBox == null ||
        !cellBox.hasSize ||
        !boardBox.hasSize ||
        !overlayBox.hasSize ||
        !cellBox.attached ||
        !boardBox.attached) {
      return;
    }

    final cellTopLeft = overlayBox.globalToLocal(
      cellBox.localToGlobal(Offset.zero),
    );
    final boardTopLeft = overlayBox.globalToLocal(
      boardBox.localToGlobal(Offset.zero),
    );
    final cellSize = cellBox.size;
    final boardSize = boardBox.size;
    final pad = QuickNumberPad.extent;
    const gap = 6.0;
    // Keep pad inside the board face (match grid outer padding).
    const inset = 8.0;

    final boardLeft = boardTopLeft.dx + inset;
    final boardRight = boardTopLeft.dx + boardSize.width - inset;
    final boardTop = boardTopLeft.dy + inset;
    final boardBottom = boardTopLeft.dy + boardSize.height - inset;

    // Prefer toward board center: top half → below cell, bottom half → above.
    final placeBelow = widget.cellRow < 4;
    var top = placeBelow
        ? cellTopLeft.dy + cellSize.height + gap
        : cellTopLeft.dy - pad - gap;

    // Directly above/below: horizontally center on the cell.
    var left = cellTopLeft.dx + cellSize.width / 2 - pad / 2;

    // Clamp so the whole pad stays inside the board.
    final maxLeft = (boardRight - pad).clamp(boardLeft, double.infinity);
    final maxTop = (boardBottom - pad).clamp(boardTop, double.infinity);
    left = left.clamp(boardLeft, maxLeft);
    top = top.clamp(boardTop, maxTop);

    final next = Offset(left, top);
    if (_topLeft != next) {
      setState(() => _topLeft = next);
    }
  }

  @override
  Widget build(BuildContext context) {
    final topLeft = _topLeft;

    return Stack(
      children: [
        // Full-screen dismiss layer: any tap outside the pad closes it,
        // including the currently selected cell.
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: widget.onDismiss,
            child: const SizedBox.expand(),
          ),
        ),
        if (topLeft != null)
          Positioned(
            left: topLeft.dx,
            top: topLeft.dy,
            child: QuickNumberPad(
              onNumberTap: widget.onNumberTap,
              highlightedNumbers: widget.highlightedNumbers,
              hintBoxNumbers: widget.hintBoxNumbers,
              hintColumnNumbers: widget.hintColumnNumbers,
              hintRowNumbers: widget.hintRowNumbers,
            ),
          ),
      ],
    );
  }
}

class _DifficultyIcon extends StatelessWidget {
  const _DifficultyIcon({required this.level});

  final int level;

  @override
  Widget build(BuildContext context) {
    final inactiveColor = IconTheme.of(context).color ?? Colors.white;
    final activeColor = Theme.of(context).colorScheme.error;

    return SizedBox(
      width: 24,
      height: 24,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            width: 3,
            height: 16,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: index < level ? activeColor : inactiveColor,
              borderRadius: BorderRadius.circular(2),
            ),
          );
        }),
      ),
    );
  }
}

class _GameStatusBadge extends StatelessWidget {
  const _GameStatusBadge({
    required this.icon,
    required this.value,
    required this.accentColor,
    this.isAlert = false,
  });

  final IconData icon;
  final String value;
  final Color accentColor;
  final bool isAlert;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final contentColor = isAlert
        ? accentColor
        : colorScheme.onSurfaceVariant.withValues(alpha: 0.72);

    return SizedBox(
      height: 28,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Icon(
              icon,
              key: ValueKey(isAlert),
              size: 16,
              color: contentColor,
            ),
          ),
          const SizedBox(width: 6),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            transitionBuilder: (child, animation) =>
                FadeTransition(opacity: animation, child: child),
            child: Text(
              value,
              key: ValueKey(value),
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: contentColor,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.15,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
