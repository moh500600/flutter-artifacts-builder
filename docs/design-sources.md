# Design sources reviewed, and what was applied

Ten public "anti AI-slop" design sources were reviewed for this project (November 25, 2026).
All are web/React-oriented; this project adapts what survives translation to Flutter.
Nothing was copied verbatim; the SKILL.md text is original.

| # | Source | What it is | Applied here |
|---|--------|-----------|--------------|
| 1 | [Uizze](https://uizze.com) | Searchable library of real UI screens as agent reference | Concept only: "show what good looks like" -> golden screenshots as the reference output |
| 2 | [Impeccable](https://impeccable.style) | Design vocabulary + before/after slop patterns | Hierarchy over decoration; no kicker/badge soup, start-aligned headers, one accent color |
| 3 | [taste-skill](https://github.com/leonxlnx/taste-skill) | Anti-slop frontend skill with a browser finish gate | "One system" rule -> single theme file + spacing scale; gate idea -> test-artifact.sh |
| 4 | [emil-design-eng](https://github.com/emilkowalski/skill) | Design-engineering philosophy (states, motion, unseen details) | Interactive states everywhere (press, completion, selection); no dead controls |
| 5 | [web-design-guidelines](https://github.com/vercel-labs/agent-skills) | Vercel's UI review rules with file:line findings | Review-gate concept; accessibility items that translate (contrast, hit areas) |
| 6 | [frontend-design](https://github.com/anthropics/skills/tree/main/skills/frontend-design) (Anthropic, Apache-2.0) | Distinctive, non-templated visual direction | Ground design in the subject; deliberate palette/typography instead of defaults |
| 7 | [Hallmark](https://github.com/nutlope/hallmark) | 50 themes + hard "floor" gates against slop tells | Floor-gate concept -> analyze + tests + inspected goldens as the ship gate |
| 8 | [make-interfaces-feel-better](https://github.com/jakubkrehel/make-interfaces-feel-better) | Polish details: surfaces, typography, motion restraint | Spacing scale (4/8/12/16/24), flat surfaces with tonal color instead of shadows, restrained motion |
| 9 | [ui-ux-pro-max](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) | 194 rules + searchable style database | General checklist inspiration; web-specific rules not ported |
| 10 | [stageshow](https://github.com/benjitaylor/skills/tree/main/stageshow) | Faux product-UI illustrations for marketing | Not applicable to app building (marketing mockups); noted for future use |

## Flutter-specific choices that replace web guidance

- **Golden screenshot tests stand in for browser lint gates.** They run anywhere `flutter test` runs and produce reviewable PNGs with real fonts and icons.
- **RTL is a first-class state**, not an afterthought: the template ships an Arabic locale toggle and the goldens verify it.
- **The "artifact bundle" is a real build** (APK / static web), not an inlined HTML file.
- **No CDN or runtime font fetching**: the font is a bundled asset, so the artifact works offline and renders identically everywhere.
