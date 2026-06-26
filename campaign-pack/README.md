# Campaign Asset Pack Demo

This demo uses Open Design as a campaign design assistant while keeping final rendering deterministic.

Open Design creates and edits `campaign.json`. A fixed local Chromium renderer reads that JSON and exports production-size PNG assets:

```text
exports/keynote-16x9.png      1920x1080
exports/vertical-poster.png   1080x1920
exports/social-square.png     1080x1080
exports/linkedin-banner.png   1584x396
```

The model never writes the renderer HTML. That keeps the live demo predictable: the creator can iterate on message, mood, hierarchy, and asset choices without breaking export formatting.

The demo also supports concept sets. Open Design can create `campaign-a.json`, `campaign-b.json`, and `campaign-c.json`, then the renderer exports every pack plus a `contact-sheet.png` for creative review.

## One-Time Setup

From the repo root:

```bash
./campaign-pack/scripts/install-renderer-deps.sh
```

This installs a local Playwright renderer under `campaign-pack/.tools/playwright/` and downloads Playwright's Chromium browser.

## Demo Flow

1. Create a new Open Design project.
2. Copy your campaign assets into the project folder. At minimum:

   ```bash
   cp assets/nvidia/nvidia-logo-horz.svg open-design/.od/projects/<project-id>/
   cp content-video-demo/assets/cover.png open-design/.od/projects/<project-id>/
   ```

3. In Open Design, run `campaign-pack/prompts/01-create-campaign-json.md`.
4. Iterate with the creator using plain-language direction:

   ```text
   Edit campaign.json only. Make the campaign feel more premium and reduce the headline to six words.
   ```

5. Render the asset pack:

   ```bash
   node campaign-pack/scripts/render-pack.mjs open-design/.od/projects/<project-id>/campaign.json
   ```

The PNGs are written to `exports/` beside the `campaign.json` file.

## Multi-Concept Review Flow

Use this when you want a more visual ideation moment.

1. Create a new Open Design project and copy the local assets into it.
2. In Open Design, run `campaign-pack/prompts/03-create-concept-set.md`.
3. Iterate on one or more JSON files:

   ```text
   Edit campaign-b.json only. Make this direction more cinematic and reduce the subhead.
   ```

4. Render all concepts and a contact sheet:

   ```bash
   node campaign-pack/scripts/render-concepts.mjs open-design/.od/projects/<project-id>
   ```

The renderer writes:

```text
exports/campaign-a/
exports/campaign-b/
exports/campaign-c/
exports/contact-sheet.html
exports/contact-sheet.png
```

## Prompt Files

- `prompts/01-create-campaign-json.md` creates the initial structured campaign direction.
- `prompts/02-refine-campaign-json.md` is a reusable edit prompt for follow-up design direction.
- `prompts/03-create-concept-set.md` creates three distinct campaign directions.

## Sample

Render the included sample from the repo root:

```bash
node campaign-pack/scripts/render-pack.mjs campaign-pack/sample/campaign.json
```

Render the sample as a contact sheet:

```bash
node campaign-pack/scripts/render-concepts.mjs campaign-pack/sample
```

The sample uses existing repo assets so the renderer can be tested immediately after install.
