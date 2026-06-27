Apply the current critique to one campaign JSON file in place.

Read `critique.md` first. Then read the campaign JSON file named by the creator. If no file is named, use the source file listed in `critique.md`.

Edit the selected campaign JSON file directly. Do not create a separate `-revised.json` file.

Before changing the selected file, verify that a matching before snapshot exists:

```text
<base-name>-before.json
```

Examples:
- if editing `campaign-a.json`, verify `campaign-a-before.json` exists
- if editing `campaign-a-cyan-purple.json`, verify `campaign-a-cyan-purple-before.json` exists
- if editing `campaign.json`, verify `campaign-before.json` exists

Do not edit the before snapshot. Do not create or edit HTML, CSS, JavaScript, SVG, renderer, markdown, image files, or any other JSON file.

Preserve the base file's schema exactly:

```json
{
  "campaignName": "Short campaign name",
  "brand": {
    "name": "Brand or product name",
    "logo": "relative/path/to/logo.svg"
  },
  "assets": {
    "hero": "relative/path/to/hero-or-product-image.png"
  },
  "theme": {
    "background": "#05070d",
    "surface": "rgba(14, 19, 29, 0.78)",
    "primary": "#76B900",
    "accent": "#4de7ff",
    "secondary": "#b26cff",
    "text": "#f7fbff",
    "muted": "#9da8b7"
  },
  "copy": {
    "eyebrow": "Short context line",
    "headline": "Strong campaign headline",
    "subhead": "One sentence value proposition.",
    "cta": "Short call to action",
    "footer": "Short footer or event label"
  },
  "layout": {
    "mood": "visual mood in one phrase",
    "imagePlacement": "right",
    "density": "balanced"
  },
  "notes": [
    "Creator remains the art director."
  ]
}
```

Rules:

- Preserve `brand.logo` and `assets.hero` exactly unless the creator explicitly asks to change assets.
- Keep the headline under 9 words.
- Keep the subhead under 26 words.
- Make revisions visible enough to justify a before/after review board.
- Improve clarity, hierarchy, brand fit, and format adaptability based on `critique.md`.
- Keep valid JSON only.
- Do not include markdown fences in the JSON file.
- Do not output JSON in chat.

After editing the selected JSON, verify it still exists and is valid JSON, then reply DONE.
