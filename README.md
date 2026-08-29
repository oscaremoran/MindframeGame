# Mindframe — Defense of System 001

A single-file browser space shooter set in the world of **"Mindframe"** by Oscar Moran.
You are the last human pilot in System 001. Five waves of Iterations are inbound.
You have one life.

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
| ⬛ | **The Ruler** | The Wave 5 boss. An ever-changing black shape. Cycles a radial ring, an aimed fan, and summoning Watchers — and enrages below 28% HP. |

## The Mindframe tree

Score earns skill points (1 per 400). The tree stays locked until your first Wave 5
clear, then opens permanently — spend points, relaunch at Wave 1 stronger, repeat.
Four branches of three:

- **Pulse Calibration → Focused Pulse → Phase Rounds** — damage, then piercing shots
- **Feed Overclock → Twin Emitters → Triple Spread** — fire rate, then a 3-shot spread
- **Hull Plating → Ablative Weave → Repair Field** — max HP, then passive regeneration
- **Thrust Vectoring → Blink Drive → Deflector** — speed, then a dash with i-frames

Progress, points, best score and furthest wave persist in `localStorage`.

## Story

The full text of *Mindframe* is readable from the title screen.

## Structure

Everything is in `index.html` — markup, styles, and the game in one vanilla-JS
`<canvas>` file. No dependencies.
