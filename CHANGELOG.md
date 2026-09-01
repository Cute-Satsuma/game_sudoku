# Changelog

All notable changes to this project will be documented in this file.

Version scheme: `yyyyMMdd.counter+yyMMddcounter` (e.g. `20260901.01+26090101`).

## [20260901.01] - 2026-09-01

### Changed

- Cleaned the repository: removed Actions workflows, release scripts, and credential templates
- Switched to date-based versionName / versionCode

## [1.2.1] - 2026-08-30

### Added

- **Quick number pad** — tap a selected cell again to open a compact 3×3 pad on the board (toward center, stays inside the grid)
- **Settings toggle** — enable or disable the quick number pad under Gameplay

## [1.2.0] - 2026-08-29

### Added

- **Notes mode** — pencil marks in empty cells with fixed 3×3 positions
- **Autofill assist** — wand fills the selected cell; long-press enables tap-to-fill mode
- **Animated home logo** — orbiting mark with soft board glow and Sudoku | CAJU wordmark

### Changed

- Clearer wrong digits (bold red) without sticky selection frames
- Correct entries lock so they cannot be reselected or cleared
- Removed glass card behind the home logo for a cleaner hero

## [1.1.0] - 2026-08-28

### Added

- **Theme settings** — appearance (system/light/dark), color palettes, paper texture, fonts, and icon styles
- **First-run onboarding** — theme guide spotlight and color picker for new players

### Changed

- Refined game status UI and softer theme presentation
- Two-row number pad layout with unified green styling
- Sudoku Caju branding across app, web, and store metadata

## [1.0.2] - 2026-08-17

### Changed

- Public app name is now **Sudoku Caju** (Chinese: **数独 Caju**)

## [1.0.0] - 2026-02-13

### Added

- **Free Play Mode** - Choose difficulty (Easy/Medium/Hard) and play unlimited puzzles
- **Campaign Mode** - 999 levels across 3 difficulty tiers, progress saved locally
- **Instant Feedback** - Green highlight for correct answers, red for wrong ones
- **Rules Guide** - Built-in Sudoku rules and how-to-play instructions
- **Multi-language Support** - 18 languages: English, Chinese, Japanese, Korean, Spanish, French, German, and more
- **Timer** - Track completion time for each puzzle
- **Progress Persistence** - Campaign progress saved with get_storage

### Technical

- Flutter 3.x with Material 3
- Supports Android, iOS, macOS, Web, Windows, Linux
