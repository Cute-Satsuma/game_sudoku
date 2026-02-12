import 'dart:async';

import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../services/campaign_progress.dart';
import '../sudoku/sudoku_generator.dart';
import '../sudoku/sudoku_validator.dart';
import '../widgets/number_pad.dart';
import '../widgets/sudoku_grid.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({
    super.key,
    this.campaignMode,
    this.campaignLevel,
  });

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
  Set<({int row, int col})> _errorCells = {};
  Set<({int row, int col})> _correctCells = {};
  int _difficulty = 2; // 1=Easy, 2=Medium, 3=Hard (Free Play)
  int _elapsedSeconds = 0;
  Timer? _timer;
  bool _isCompleted = false;

  bool get _isCampaign => widget.campaignMode != null && widget.campaignLevel != null;
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
    _errorCells = {};
    _correctCells = {};

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!_isCompleted) {
        setState(() => _elapsedSeconds++);
      }
    });
  }

  void _onCellTap(int row, int col) {
    if (_initialPuzzle[row][col] != 0) return; // Fixed cells are not editable

    setState(() {
      _selectedCell = (row: row, col: col);
    });
  }

  void _onNumberTap(int number) {
    if (_selectedCell == null) return;
    if (_isCampaign && _isGameOver) return;

    final (row: row, col: col) = _selectedCell!;
    if (_initialPuzzle[row][col] != 0) return;

    setState(() {
      if (_isNotesMode) {
        // Notes mode not implemented yet, fill number directly
        _grid[row][col] = number;
        _checkAndUpdateFeedback(row, col, number);
      } else {
        _grid[row][col] = number;
        _checkAndUpdateFeedback(row, col, number);

        if (SudokuValidator.isComplete(_grid)) {
          _isCompleted = true;
          _timer?.cancel();
          _showWinDialog();
        }
      }
    });
  }

  /// Check if input is correct against solution, update correct/error highlights
  void _checkAndUpdateFeedback(int row, int col, int number) {
    final isCorrect = number == _solution[row][col];
    if (isCorrect) {
      _correctCells = {..._correctCells, (row: row, col: col)};
      _errorCells = _errorCells.difference({(row: row, col: col)});
    } else {
      _errorCells = {..._errorCells, (row: row, col: col)};
      _correctCells = _correctCells.difference({(row: row, col: col)});
      if (_isCampaign) {
        _errorCount++;
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
    if (_initialPuzzle[row][col] != 0) return;

    setState(() {
      _grid[row][col] = 0;
      _errorCells = _errorCells.difference({(row: row, col: col)});
      _correctCells = _correctCells.difference({(row: row, col: col)});
    });
  }

  void _onNotes() {
    setState(() => _isNotesMode = !_isNotesMode);
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
        content: Text(
          l10n.congratsDescFormatted(_formatTime(_elapsedSeconds)),
        ),
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
                _difficulty == 1 ? Icons.radio_button_checked : Icons.radio_button_off,
              ),
              onTap: () {
                _difficulty = 1;
                Navigator.pop(ctx);
                _newGame();
              },
            ),
            ListTile(
              title: Text(l10n.difficultyMedium),
              leading: Icon(
                _difficulty == 2 ? Icons.radio_button_checked : Icons.radio_button_off,
              ),
              onTap: () {
                _difficulty = 2;
                Navigator.pop(ctx);
                _newGame();
              },
            ),
            ListTile(
              title: Text(l10n.difficultyHard),
              leading: Icon(
                _difficulty == 3 ? Icons.radio_button_checked : Icons.radio_button_off,
              ),
              onTap: () {
                _difficulty = 3;
                Navigator.pop(ctx);
                _newGame();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),
      appBar: AppBar(
        title: Text(
          _isCampaign
              ? AppLocalizations.of(context).level(widget.campaignLevel!)
              : AppLocalizations.of(context).sudoku,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          if (_isCampaign)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Center(
                child: Text(
                  AppLocalizations.of(context).errors(_errorCount, _maxErrors),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _errorCount >= _maxErrors - 2
                        ? Colors.red.shade200
                        : Colors.white,
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(
              child: Text(
                _formatTime(_elapsedSeconds),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _newGame,
            tooltip: _isCampaign
                ? AppLocalizations.of(context).replayLevel
                : AppLocalizations.of(context).newGame,
          ),
          if (!_isCampaign)
            IconButton(
              icon: const Icon(Icons.tune),
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
                    const CircularProgressIndicator(color: Color(0xFF2E7D32)),
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context).loading,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              )
            : LayoutBuilder(
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
                    const SizedBox(height: 16),
                    SudokuGrid(
                      grid: _grid,
                      initialPuzzle: _initialPuzzle,
                      selectedCell: _selectedCell,
                      onCellTap: _onCellTap,
                      errorCells: _errorCells,
                      correctCells: _correctCells,
                    ),
                    const SizedBox(height: 24),
                    NumberPad(
                      onNumberTap: _onNumberTap,
                      onClear: _onClear,
                      onNotes: _onNotes,
                      isNotesMode: _isNotesMode,
                      enabled: !(_isCampaign && _isGameOver),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
