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
| `P` | Pause menu |
| `Esc` | Back one screen — and pauses a run |
| `Enter` | Presses the main button on the current screen |
| `G` | Opens the Garage (during its Pilot School lesson) |

## Pilot School

A coached tutorial that **opens itself every time you load the page until you
finish it once**. You fly; the caption panel teaches. Each lesson only clears
when you actually do the thing:

1. **Thrust** — fly through four markers, learning momentum and drag
2. **Aim and fire** — destroy four inert practice drones
3. **Hull** — survive fifteen seconds under fire
4. **Engage** — clear a live Iteration and two Watchers
5. **Supply** — collect three powerup cells
6. **The Garage** — opens the real Garage screen, mid-lesson

When you buy a skill that has a lesson, the title screen's **PILOT SCHOOL**
button lights up with a count of new drills waiting, and clears once you have
flown them.

Extra lessons appear for the tier-3 skills you own — **Blink Drive**, **Triple
Spread**, **Phase Rounds**, **Repair Field** — so the school grows with the save.
Nothing dies in the simulator: hitting zero hull just restores it. It scores
nothing and earns no points, and leaving early (**ESC** or **EXIT SCHOOL**)
does not count as finishing, so it will open again next time. **PILOT SCHOOL**
on the title screen replays it. The completion flag is local to the browser and
is not carried in save codes.

## Powerups

Wrecks drop cells. They drift, pull toward you from close range, and burn out
after about fourteen seconds — the last few seconds blink as a warning.

| | Cell | Effect |
|---|---|---|
| 🟢 | **Hull Repair** | Instantly restores 30% of your hull. Only drops when you are below 80%. |
| 🔵 | **Overclock** | Fire rate nearly doubled for 11s. |
| 🔴 | **Overcharge** | 1.8× damage for 11s — rounds turn red. |
| 🩵 | **Barrier** | 6.5s of complete immunity, shown as a ring around the ship. |
| 🟠 | **Scatter** | A temporary 3-shot spread for 12s, even without the skill. |

Heavier enemies drop more often (a Primary about half the time, the Ruler always
drops three). Active cells show as timer bars under your hull readout.

## Difficulty

**System 001 is a runway.** Its first waves come in thinner, softer and slower —
enemy hull, speed, rate of fire, shot damage *and* aim all scale up across waves
1–4 (62% → 92% of full weight) before the Ruler — hostiles are held to five or
six on screen at once instead of arriving as a pile-up, and clearing a wave
patches you up by 10%. Systems 002–004 are unchanged: full weight, full aim, no
queue limit, no between-wave repair.

A headless bot that never dodges and never picks up a cell reaches the Ruler in
most System 001 runs, and dies to it.

## Enemies

| | Name | Behaviour |
|---|---|---|
| 🔵 | **Iteration** | Holds its distance and orbits — and reverses that orbit when you settle into it. Leads its shots. Double-taps from System 003. |
| 🟢 | **Watcher** | Fast and fragile. Flies an *intercept* course rather than chasing your tail, and commits at close range. Dies on impact. |
| 🔴 | **Primary** | Slow, tanky, never retreats. Leads its shots, and from System 002 sometimes braces for a five-shell spread. |
| 🟠 | **Tracker** | *(System 002+)* Hangs back and launches homing seekers that burn out after ~4.5s. Fires two at a time from System 003. |
| 🩵 | **Overseer** | *(System 003+)* Its shield arc drifts toward whichever side you are shooting from, so flanking it is continuous work. |
| 🟣 | **Splinter** | *(System 004+)* Weaves in, speeds up at close range, and bursts into two Watchers when killed. |
| ⬛ | **The Ruler** | The Wave 5 boss — see below. |

### The Ruler

It fights in three tiers, each keeping everything from the one before:

| Hull | Tier | What it brings |
|---|---|---|
| 100–62% | — | Radial rings, an aimed fan, and summoned escorts. |
| 62–28% | **Escalating** | Adds a **charged lance** (it aims a line at you for ~1s, then fires down it) and a **spiral barrage**. |
| below 28% | **Enraged** | Adds **blinking** across the field, presses in close, and cycles attacks roughly twice as fast. |

Crossing a tier is an event: it becomes untouchable for a second, the shockwave
wipes every enemy bullet off the screen, and the boss bar marks the thresholds.
Its hull scales with the pilot — `980 × system × (1 + 0.09 per skill you own)` —
so it arrives ready for whatever you spent your points on. Every heavy attack is
telegraphed before it lands.

## The Garage

Four hulls, pure stat trade-offs — no hidden rules. A hull is gated **twice**:
you have to have flown deep enough to unlock it, and then pay skill points for
it, so hulls compete with the Mindframe tree for the same currency.

| Ship | Class | HULL | POWER | RATE | SPEED | GRIP | Unlock |
|---|---|---|---|---|---|---|---|
| **LANCER** | Standard pattern | C | C | C | C | C | free |
| **BULWARK** | Assault hull | A | B | D | D | C | clear System 001 · 5 pts |
| **NEEDLE** | Interceptor | E | D | B | A | A | clear System 002 · 10 pts |
| **VERDICT** | Siege gunship | C | A | B | D | D | clear System 003 · 16 pts |

GRIP is handling — how hard the ship can push against its own drift. The letter
grades are *computed* from the multipliers rather than written by hand, so a
card can never lie about a ship. Each hull has its own silhouette in flight.

## Bestiary

Everything the game expects you to know lives on one tabbed screen — **HOSTILES**
(with entries you have not met yet dimmed), **CELLS**, and **CONTROLS** — reachable
from the title screen and from the pause menu.

## Getting around

`Esc` backs out of any screen and pauses a run; `Enter` presses the main button
on whatever is in front of you. `P` or `Esc` in flight opens a pause menu with
**RESUME**, the skill tree, the bestiary, and **QUIT TO TITLE** — quitting banks
your score and points and ends the run.

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
points, unlocked skills, unlocked hulls, best score and furthest system — as
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
