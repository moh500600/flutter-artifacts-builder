---
name: flutter-artifacts-builder
description: Suite of tools for creating elaborate, multi-component Flutter/Dart application artifacts (polished mobile and web apps with navigation, state management, theming and tests). Use for complex Flutter apps requiring multiple screens, state, theming, or custom widgets - not for single-file snippets or throwaway demos.
license: Apache-2.0 (see LICENSE)
---

# Flutter Artifacts Builder

To build powerful Flutter artifacts, follow these steps:
1. Initialize the project using `scripts/init-artifact.sh`
2. Develop your app by editing the generated code
3. Verify quality using `scripts/test-artifact.sh` (analysis, tests, golden screenshots)
4. Produce shareable builds using `scripts/bundle-artifact.sh`
5. Deliver the build to the user, with screenshots

**Stack**: Flutter 3.50+ / Dart 3.14+ - Material 3 - provider (state) - flutter_lints (analysis) - Tajawal font (Arabic + Latin, bundled)

## Design & Style Guidelines

VERY IMPORTANT: To avoid what is often referred to as "AI slop" in generated Flutter UIs:
- Do not ship the default `flutter create` look. Set a real color scheme (ColorScheme.fromSeed with a deliberate seed, not the default purple), a real text theme, and a deliberate app bar treatment.
- Avoid excessive centered layouts: align content to the start, use real information hierarchy (headline -> section -> list).
- Avoid purple/blue gradients as a personality substitute, uniform rounded corners on every element, and drop shadows on everything.
- Use a spacing scale (4/8/12/16/24) and stick to it. Empty space is fine; cramped padding is not.
- Every interactive element must do something. No dead buttons.
- Support dark theme from the start (the template already wires it).
- If the audience may read Arabic, test RTL early (the template ships an English/Arabic toggle and a font that covers both).

## Quick Start

### Step 1: Initialize Project

```bash
bash scripts/init-artifact.sh <project-name>
cd <project-name>
```

This creates a fully configured Flutter project with:
- Material 3 theming (light + dark) driven by a single seed color
- Tajawal font bundled as an asset (professional Arabic + Latin rendering, works offline)
- provider-based app state (theme mode + locale) ready to extend
- Navigation shell with three starter screens (dashboard, explore, settings)
- Strict lints via analysis_options.yaml
- Widget tests and golden screenshot tests wired up

### Step 2: Develop Your App

Edit the generated code. Conventions:
- `lib/theme/` - colors, text theme, spacing constants
- `lib/state/` - ChangeNotifier app state (extend, or swap for riverpod/bloc on bigger apps)
- `lib/screens/` - full-screen pages
- `lib/widgets/` - reusable components
- `lib/models/` - data classes and sample data (replace sample data with real sources)

Keep widgets small and composed. Business logic belongs in state/models, not in build().

### Step 3: Verify Quality

```bash
bash scripts/test-artifact.sh <project-dir>
```

Runs flutter analyze, then the test suite, then prints the golden screenshot paths.
Golden references ship with the template (generated on Linux, Flutter 3.50.1, the
version CI pins), so tests compare against them immediately and a visual regression
fails. If the local machine renders slightly differently, regenerate once with
`--update-goldens`, INSPECT the PNGs, and use those as the references. After
intentional visual changes, regenerate references the same way, and always INSPECT the
PNGs - do not treat coordinates or passing tests as proof the UI looks right.

### Step 4: Bundle Shareable Builds

```bash
bash scripts/bundle-artifact.sh <project-dir> [apk|web|all]
```

- `web` -> `dist/<name>-web.zip`: a static site you can deploy to any host.
- `apk` -> `dist/<name>-release.apk`: installable Android build (requires Android SDK;
  signed with the debug key - set up a real upload key before store publishing).

### Step 5: Deliver

Share the build artifact plus the golden screenshots with the user so they can see
exactly what they are getting. Prefer real screenshots over descriptions.

## Testing Notes

Golden tests load the bundled Tajawal fonts, so screenshots show real typography
(not Ahem blocks). They render at 360x800 logical pixels, light + dark + Arabic RTL
states. Goldens are environment-sensitive: regenerate them on the machine that owns
the verification step and review them as part of any UI change.
