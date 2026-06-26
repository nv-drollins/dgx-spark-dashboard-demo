Edit `index.html` only.

The current page failed HyperFrames render validation. This is a surgical repair pass, not a redesign pass.

Preserve the approved card exactly:
- Do not rewrite the document from scratch.
- Do not change the visual concept, copy, colors, typography, image choice, or layout hierarchy.
- Do not convert the card into a circle, badge, medallion, logo lockup, or new layout.
- Do not change existing border radius, aspect ratio, card shape, or artwork placement unless it is required to keep content inside the 1080x1920 frame.
- Do not replace the approved visual content with a simplified fallback.
- Keep `cover.png` as the artwork source.
- Use small search/replace style edits only.

## HyperFrames Contract Fixes

1. If the root composition element is missing or malformed, repair only its opening tag so it is exactly:

```html
<div id="stage" data-composition-id="teaser" data-start="0" data-width="1080" data-height="1920" data-duration="6">
```

If a custom `<stage ...>` element exists, replace only the opening `<stage ...>` tag with the div above and replace only its closing `</stage>` with `</div>`. Keep all inner HTML unchanged.

2. If the scene wrapper is missing or malformed, repair only its opening tag so it is exactly:

```html
<div id="scene-main" class="scene clip" data-start="0" data-duration="6" data-track-index="0">
```

Keep all existing content inside the scene. If the scene wrapper already exists, do not rebuild its children.

3. Make sure all visible content remains inside:

```html
<div class="scene-content">...</div>
```

If wrapping is needed, wrap the existing approved content. Do not recreate it.

4. Update CSS selectors that target `stage` so they target `#stage`. Do not otherwise rewrite the design CSS.

5. Add this render guard CSS near the end of the existing `<style>` block. If a `style` block with `id="hf-render-guard"` already exists, update only that block:

```css
/* HyperFrames render guard: production frame only, not visual redesign. */
#stage {
  position: relative;
  width: 1080px;
  height: 1920px;
  overflow: hidden;
  isolation: isolate;
  transform-origin: 0 0;
}

#scene-main,
#stage .scene,
#stage .clip {
  position: absolute;
  inset: 0;
  width: 100%;
  height: 100%;
  overflow: hidden;
}

#stage .scene-content {
  position: relative;
  width: 100%;
  height: 100%;
  box-sizing: border-box;
  overflow: hidden;
}
```

Do not use this repair prompt to force a new card size or shape. If the card is too small, use `08-fix-video-size-and-framing.md` after this repair.

## Timeline Fix

Repair the GSAP timeline registration without changing the approved card design.

If the existing timeline already has custom animation tweens, preserve them where possible. Ensure these required lines exist after `const tl = gsap.timeline({ paused: true });`:

```javascript
const __hfDurationKeeper = { progress: 0 };
tl.to(__hfDurationKeeper, { duration: totalDuration, progress: 1, ease: "none" }, 0);
```

If the current timeline is broken, missing, array-registered, wrapped in `DOMContentLoaded`, or uses `tl.play()`, replace only the bottom animation script with this frame-safe timeline:

```javascript
const totalDuration = 6;
const floatCycleDuration = 3;
const tl = gsap.timeline({ paused: true });
const __hfDurationKeeper = { progress: 0 };
tl.to(__hfDurationKeeper, { duration: totalDuration, progress: 1, ease: "none" }, 0);

tl.from(".scene-content", { duration: 1, opacity: 0, y: 36, ease: "power2.out" }, 0.5);
tl.from("h1, .episode-title, .episode-number", { duration: 0.8, opacity: 0, scale: 0.94, ease: "back.out(1.45)" }, 1.0);
tl.from(".description, .cta, .cta-button, .tag", { duration: 0.7, opacity: 0, y: 18, stagger: 0.08, ease: "power2.out" }, 1.25);

tl.to(".cover-art", {
  duration: floatCycleDuration,
  y: "-=16",
  scale: 1.012,
  repeat: Math.floor(totalDuration / floatCycleDuration) - 1,
  yoyo: true,
  ease: "sine.inOut"
}, 0);

tl.to(".glass-card", {
  duration: floatCycleDuration,
  y: "-=8",
  rotate: 0.15,
  repeat: Math.floor(totalDuration / floatCycleDuration) - 1,
  yoyo: true,
  ease: "sine.inOut"
}, 0);

tl.to(".orb-cyan, .glow-cyan", {
  duration: totalDuration,
  x: 48,
  y: -72,
  scale: 1.08,
  ease: "sine.inOut"
}, 0);

tl.to(".orb-purple, .glow-purple", {
  duration: totalDuration,
  x: -54,
  y: 66,
  scale: 1.08,
  ease: "sine.inOut"
}, 0);

window.__timelines = window.__timelines || {};
window.__timelines["teaser"] = tl;
```

If the approved card does not already have these classes, add classes to the existing elements only:
- add `cover-art` to the existing `cover.png` image
- add `glass-card` to the existing main card container
- add `orb-cyan` / `orb-purple` or `glow-cyan` / `glow-purple` to existing background glow elements

Do not create a new card to satisfy these selectors.

Important:
- Do not initialize `window.__timelines` as an array.
- Do not call `window.__timelines.push(...)`.
- Do not wrap timeline registration in `DOMContentLoaded`.
- Do not use `repeat: -1`.
- Do not call `tl.play()`.
- Do not call the composition ID `prompt-pixel-ep42`; use `teaser`.
- Do not output HTML in chat.

Before replying DONE, self-check that `index.html` contains:

```text
data-composition-id="teaser"
data-start="0"
data-width="1080"
data-height="1920"
data-duration="6"
class="scene clip"
data-track-index="0"
window.__timelines["teaser"]
__hfDurationKeeper
```

Also verify it does not contain:

```text
window.__timelines = []
window.__timelines.push
repeat: -1
tl.play
```

After editing, verify `index.html` exists, then reply DONE.
