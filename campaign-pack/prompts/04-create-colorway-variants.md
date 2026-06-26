Create colorway variants from an existing campaign concept.

Write JSON files only. Do not create or edit HTML, CSS, JavaScript, SVG, renderer files, or image files.

Use one existing campaign JSON file as the base direction. Prefer the file the creator names in chat, such as `campaign-a.json`, `campaign-b.json`, or `campaign-c.json`. If no base file is named, use `campaign.json` if it exists; otherwise use `campaign-a.json`.

Create exactly three colorway variant files:

```text
<base-name>-green.json
<base-name>-cyan-purple.json
<base-name>-mono.json
```

Examples:
- if the base is `campaign-a.json`, write `campaign-a-green.json`, `campaign-a-cyan-purple.json`, and `campaign-a-mono.json`
- if the base is `campaign.json`, write `campaign-green.json`, `campaign-cyan-purple.json`, and `campaign-mono.json`

Preserve the selected base concept's:
- brand name
- logo path
- hero image path
- headline
- subhead
- CTA
- footer
- notes
- layout density and image placement

Change only:
- `campaignName`
- `theme`
- `layout.mood`
- optionally `copy.eyebrow` if it helps label the variant

Use these colorway directions:

1. Green technical
   - NVIDIA-green primary
   - dark premium background
   - restrained cyan accent
   - mood: "green technical precision"

2. Cyan purple creator
   - cyan primary
   - purple secondary
   - luminous creator-energy background
   - mood: "cyan purple creator energy"

3. Monochrome premium
   - near-black background
   - white/silver text
   - subtle green accent only
   - mood: "monochrome premium launch"

Each file must follow the same schema as the base campaign file:

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
- Keep all local asset paths unchanged from the base file.
- Do not rewrite the copy except `campaignName`, `layout.mood`, and optionally `copy.eyebrow`.
- Do not include markdown fences in the JSON files.
- Do not output JSON in chat.

After writing the three files, verify they exist and are valid JSON, then reply DONE.
