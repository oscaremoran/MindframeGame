# Mindframe — Defense of System 001

A single-file browser space shooter set in the world of **"Mindframe"** by Oscar Moran.
You are the last human pilot. Four systems, five waves each, and one life for the
whole campaign.

**[Play it](index.html)** — no install, no build step, no server. Open `index.html` in any browser.

## Controls

| Input | Action |
|---|---|
| `W` `A` `S` `D` | Thrust (momentum + drag) |
| Mouse | Aim |
| Click / `Space` | Fire |
| `Shift` | Blink dash *(requires the Blink Drive skill)* |
| `P` | Pause |

## Enemies

| | Name | Behaviour |
|---|---|---|
| 🔵 | **Iteration** | Holds its distance, strafes in a slow orbit, fires aimed pulses. |
| 🟢 | **Watcher** | Fast and fragile. Weaves toward you and rams, dying on impact. |
| 🔴 | **Primary** | Slow, tanky, never retreats. Fires three-shell volleys of heavy rounds. |
| 🟠 | **Tracker** | *(System 002+)* Hangs back at long range and launches slow homing seekers that burn out after ~4.5s. |
| 🩵 | **Overseer** | *(System 003+)* Carries a spinning shield arc that blocks every shot from the side it faces. Flank it. |
| 🟣 | **Splinter** | *(System 004+)* Drifts in on a weaving path and bursts into two Watchers when killed. |
| ⬛ | **The Ruler** | The Wave 5 boss. An ever-changing black shape. Cycles a radial ring, an aimed fan, and summoning Watchers — and enrages below 28% HP. |

## The Mindframe tree

Score earns skill points (1 per 1200). The tree stays locked until you first clear
System 001, then opens permanently — spend points, relaunch stronger, push deeper.
Tiers cost 2 / 4 / 7 points, so mastering all four branches takes several campaigns.
It is also reachable between systems, so points spent mid-run apply immediately.
Four branches of three:

- **Pulse Calibration → Focused Pulse → Phase Rounds** — damage, then piercing shots
- **Feed Overclock → Twin Emitters → Triple Spread** — fire rate, then a 3-shot spread
- **Hull Plating → Ablative Weave → Repair Field** — max HP, then passive regeneration
- **Thrust Vectoring → Blink Drive → Deflector** — speed, then a dash with i-frames

Progress, points, best score and furthest wave persist in `localStorage`.

## Save codes

**SAVE CODE** on the title screen shows a portable code for your progress —
points, unlocked skills, best score and furthest system — as
`MF1-<base64 payload>-<checksum>`. Copy it to move a save between browsers or
machines; pasting a code replaces what is stored locally. The checksum rejects
damaged or hand-edited codes.

## Systems and story text

The campaign is four systems deep, each scaling enemy HP, speed and counts, and
each introducing one new enemy via its `adds` field. Every
system carries a `brief` (shown before its waves) and a `clear` (shown when you
finish it), authored in the `SYSTEMS` block at the top of the `<script>` in
`index.html` — marked `★ WRITE YOUR TEXT HERE ★`. Blank text skips the screen, a
blank line starts a new paragraph, and a `[BRACKETED]` line renders as green
terminal output. Adding a fifth system is one more block; the waves, scaling and
ending adapt.

The full text of *Mindframe* is readable from the title screen.

## Structure

Everything is in `index.html` — markup, styles, and the game in one vanilla-JS
`<canvas>` file. No dependencies.
