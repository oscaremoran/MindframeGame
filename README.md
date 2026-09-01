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

## The cold open

**LAUNCH** does not drop you into a briefing. The defence net comes up first: a
grid unfolds from the horizon, two scan bars sweep the field, your actual hull
draws itself inside closing target rings, and a boot log reads back the save it
has been handed — hull, nodes owned, integrity, systems inbound, and the two
lines that are the whole game:

```
> RESUPPLY  . . . . . . . . .  NONE
> FALLBACK  . . . . . . . . .  NONE
```

It runs 6.2 seconds over the live starfield, under scanlines and a vignette, and
**any key or click skips it**. It is authored in `cineDraw()` as one timeline of
`t`-gated beats, so re-timing it is editing numbers, not code.

## Pilot School

A coached tutorial that **opens itself every time you load the page until you
finish it once**. You fly; the caption panel teaches. Each lesson only clears
when you actually do the thing:

1. **Thrust** — fly through four markers, learning momentum and drag
2. **Aim and fire** — destroy four inert practice drones
3. **Hull** — survive fifteen seconds under fire
4. **Engage** — clear a live Iteration and two Watchers
5. **Supply** — collect three powerup cells

**SKIP LESSON** sits under **EXIT SCHOOL** and moves you straight to the next
drill. It counts the lesson as flown, so skipping does not leave the title
screen nagging you about it.

A sixth drill, **Secret Missions**, appears only once you have finished a run
and first held System 001 — the point at which the map starts offering side
branches. It is a real salvage drill: four cells to collect with the wreckage
already drifting, while the caption explains what the branches are and what
they cost you.

When you buy a skill that has a lesson, the title screen's **PILOT SCHOOL**
button lights up with a count of new drills waiting, and clears once you have
flown them.

Extra lessons appear for the tier-3 skills you own — **Blink Drive**, **Triple
Spread**, **Phase Rounds**, **Repair Field** — so the school grows with the save.
Two of those drill the skill rather than demonstrate it, against **emplacements**:
Primaries bolted to the floor that still lead and fire, but never close.

- **Blink Drive** puts three *indestructible* emplacements on the right of the
  arena and asks for four **clean breaks**. A blink only counts if there was a
  round within 200px genuinely pointed at you when you pressed `SHIFT` — blinking
  into empty space says `NOTHING WAS COMING` and scores nothing. So the drill
  teaches the timing, not the button.
- **Repair Field** is an attrition drill. You start at 60% hull against three
  200-hull emplacements that between them out-damage the field, and you have to
  kill all three **without ever dropping under 25%**. Dropping under re-racks the
  whole drill with `PULL BACK SOONER`. The only way through is the loop the skill
  exists for: hit a target, break off before it costs more than you regain, come
  back full. The far-left corner is out of everything's range on purpose.

Nothing dies in the simulator: hitting zero hull just restores it. It scores
nothing and earns no points, and leaving early (**ESC** or **EXIT SCHOOL**)
does not count as finishing, so it will open again next time. **PILOT SCHOOL**
on the title screen replays it. The completion flag is local to the browser and
is not carried in save codes.

## The world map

**LAUNCH** opens the campaign as a route rather than dropping you straight into
System 001. It reads bottom to top like the skill tree — 001 on the floor, the
Ruler's system at the ceiling.

It is a roguelike route, not a level select: **nothing on it can be skipped**.
Every run starts at System 001 and climbs. Each system also has a dashed side
branch to a **Secret Mission** — see below.

The chart is a live readout rather than a static diagram: a clipped-corner frame
with corner brackets, a grid, drifting motes, scanlines and a scan bar crawling
up it, all on a canvas driven by the main loop. A gradient spine runs the length
of the route, and **three pulses climb the part of it you already hold** — they
read the same `MAP_X` / `MAP_Y` percentages the nodes are placed with, so the
route they light is always the route you are looking at. The segment you are
about to fly is a flowing dashed line; the `NEXT` node breathes, and an offered
secret branch pulses yellow.

Every system node carries its own numbers under the status line — the real
values from the `SYSTEMS` block, not a description of them:

```
    01
SYSTEM 002
   NEXT
×1.32 THREAT · 2 CR / WAVE · +TRACKER
```

**HELD is run state, not a record.** A node only turns green once you have
killed the thing guarding it *on this run*, so the map you launch from always
shows 001 as `NEXT` and everything above it locked, however deep the save has
been. What the save remembers is a `FURTHEST HELD` line under the title.

The map is also the screen between systems: clearing one puts you back on it
with the node you just took now green, and **CONTINUE** carries on to the next
briefing. Clearing the last system shows the whole route held before the
results.

## Secret Missions

The side branches off the world map. When the map comes up between systems, the
branch beside the system you are about to fly lights up in yellow and you choose:
**CONTINUE** up the spine, or take the detour. One offer per system per run.

A salvage or escort run pays half again what a system pays — 20 credits off
System 002, 27 off 003. A secret boss pays two and a half times: **58 credits**.
That is the only reason to go, because **failing one ends the run exactly like
dying does**.

Which branch you get is fixed by where you are on the route: 002 is Salvage,
003 is Escort, and 004 is a secret boss. One ship, one campaign, and this is the part
of it you gambled.

| | Mission | What it is |
|---|---|---|
| 🟡 | **Escort** | A yellow hauler crawls across the field on a 44-second run with 340 hull of its own. **Everything out there hunts the hauler, not you** — the whole enemy AI retargets, so you are the only thing between them and it. It is a stream, not a trickle: `11 + system×4` scheduled hostiles with Watchers arriving in pairs, plus Trackers, Overseers and Splinters as the systems allow, plus **two timed pushes** at a third and two thirds of the crossing. Escort is also the only place the arena runs **12 live hostiles instead of ten**. What reaches it hurts: a Watcher ram is 40, a Primary 34, anything else 24, and stray fire lands at 1.6×. |
| 🟢 | **Salvage** | An open debris field with green credit motes scattered through it. No hostiles and **no clock** — just wreckage that costs **34 hull** and a hard shove on contact. It opens at `17 + system×5` pieces, gains another every **1.1 seconds**, and everything already out there accelerates on a `1 + t/17` ramp — up to **76 pieces at 3.4× drift**, where it levels off. Each mote is **1 credit, banked the moment you touch it**. The `EXIT` gate is open the whole time and nothing ever forces you through it: you leave when you decide another mote is not worth the field you would have to cross to reach it. |
| 🟪 | **Secret Boss** | Nothing to collect and no clock — just the fight, off the last system's branch. One of two, picked at random each time you take it. |

Salvage is press-your-luck: what you have already picked up is yours even if the
wreck kills you, and nothing but your own judgement ends the run — greed is the
only clock. Escort pays nothing at all unless the hauler makes it. Clearing
either patches you up by 15% and drops you into the next system's briefing.

### The two off the roster

The last system's branch puts you in front of one of these, chosen fresh every
time. Both use the same three-tier escalation as the campaign bosses — nothing
they do is untelegraphed, there is just more of it and it comes faster.

| | Name | What it is |
|---|---|---|
| 🟩 | **Iteration 3295** | The Watcher that held the record before 3296. Very fast, very close, and it will not hold still: scattered fire, telegraphed rams, blinking, and it throws Splinters at you. Three nested darts, drawn in pale green. |
| 🟪 | **The Archive** | The Mindframe Upgrading Facility's core — a ring of stored minds around an empty middle. Slow, shielded by an arc you have to keep flanking, and it rakes the arena and summons Overseers. |

## Credits

Runs pay in **credits**, and credits are the only currency.

| | |
|---|---|
| Holding a wave | **1** credit in System 001, **2** in 002, **3** in 003, **4** in 004 |
| Killing a system's boss | **3** credits |
| Escort or Salvage | half again the system's total — 20 / 27 |
| A secret boss | two and a half times — 58 |

A full clean campaign is 62 credits. Score is now purely the scoreboard — it
earns nothing. Spend credits two ways:

- **Skill points** — the skill tree has an **EXCHANGE** button: 2 credits buys
  1 point. Skills still cost the points they always did.
- **Hulls** — the Garage charges credits directly.

Nothing in Pilot School pays; it is a simulator.

## Powerups

Wrecks drop cells. They drift, and once you are inside 150px they are yanked
hard toward you — a shorter reach than before, and a much stronger pull, so
collecting one is a deliberate move rather than something that happens near you.
They burn out
after about fourteen seconds — the last few seconds blink as a warning.

| | Cell | Effect |
|---|---|---|
| 🟢 | **Hull Repair** | Instantly restores 30% of your hull. Only drops when you are below 80%. |
| 🔵 | **Overclock** | Fire rate nearly doubled for 11s. |
| 🔴 | **Overcharge** | 1.8× damage for 11s — rounds turn red. |
| 🩵 | **Barrier** | 6.5s of complete immunity, shown as a ring around the ship. |
| 🟠 | **Scatter** | A temporary 3-shot spread for 12s, even without the skill. |

Heavier enemies drop more often (a Primary about half the time, a boss always
drops three). Active cells show as timer bars under your hull readout.

## Aim assist

A round that is going to miss narrowly leans into the target instead. It only
bends toward an enemy within 95px that is *ahead* of it and inside 0.8 radians
of the way it is already going, at up to 5.5 rad/s — so a shot roughly 45px wide
of a target connects and one 75px wide does not. It rescues a near miss; it does
not aim for you, and it cannot turn a round around. The three numbers are
`MAGNET_R`, `MAGNET_CONE` and `MAGNET_TURN` at the top of the script.

## Difficulty

**System 001 is a runway.** Its first waves come in thinner, softer and slower —
enemy hull, speed, rate of fire, shot damage *and* aim all scale up across waves
1–4 (62% → 92% of full weight) before Iteration 3296 — hostiles are held to five or
six on screen at once instead of arriving as a pile-up, and clearing a wave
patches you up by 10%. Systems 002–004 are unchanged: full weight, full aim, no
between-wave repair.

**Ten hostiles on screen, everywhere.** Every system now holds the spawn queue
at ten live enemies; nothing is skipped, it just waits its turn. And nothing
leaves the arena — an enemy flies in freely, and from the moment it is fully on
screen it is held inside the walls for the rest of its life.

A headless bot that never dodges and never picks up a cell reaches Iteration
3296 in most System 001 runs, and dies to it.

## Enemies

| | Name | Behaviour |
|---|---|---|
| 🔵 | **Iteration** | Holds its distance and orbits — and reverses that orbit when you settle into it. Leads its shots. Double-taps from System 003. |
| 🟢 | **Watcher** | Fast and fragile. Flies an *intercept* course rather than chasing your tail, and commits at close range. Dies on impact. |
| 🔴 | **Primary** | Slow, tanky, never retreats. Leads its shots, and from System 002 sometimes braces for a five-shell spread. |
| 🟠 | **Tracker** | *(System 002+)* Hangs back and launches homing seekers that burn out after ~4.5s. Fires two at a time from System 003. |
| 🩵 | **Overseer** | *(System 003+)* Its shield arc drifts toward whichever side you are shooting from, so flanking it is continuous work. |
| 🟣 | **Splinter** | *(System 004+)* Weaves in, speeds up at close range, and bursts into two Watchers when killed. |

### Wave 5

Every system's Wave 5 is a boss, and each one is that system's own enemy taken
to its conclusion.

| | System | Boss | What it is |
|---|---|---|---|
| 🔴 | 001 | **Iteration 3296** | A Primary that outgrew its frame — braced five-shell spreads, and a telegraphed ram down a line it shows you first. |
| 🟢 | 002 | **The Hive Mind** | A core with the swarm still around it. It spits Watchers, and sheds two more every eighth of hull you take off. |
| 🩵 | 003 | **Iteration 2117** | An Overseer with everything it learned. A wider tracking shield arc, and a rotating wall of fire across the arena. |
| ⬛ | 004 | **The Ruler** | The thing the other three answered to. Charged lances, spiral barrages, and blinking. |

They all share one shape. Each fights in three tiers, and each tier keeps
everything from the one before:

| Hull | Tier | What changes |
|---|---|---|
| 100–62% | — | Its opening kit. |
| 62–28% | second | One new attack, faster cycling, harder movement. |
| below 28% | third | Another attack, faster again, and it presses in close. |

Crossing a tier is an event: the boss becomes untouchable for a second, the
shockwave wipes every enemy bullet off the screen, and the boss bar marks the
thresholds. Boss hull scales with the pilot — `base × system × (1 + 0.05 per
skill you own)`, where base is 620 / 700 / 760 / 900 — so it arrives ready for
whatever you spent your credits on without punishing you for having spent them.
Every heavy attack is telegraphed before it lands. Escorts are capped at five on
the field, so a boss fight stays a duel rather than a pile-up.

### When one falls

A boss took a minute to kill, so it does not get to blink out in one frame.
`bossDeathFx()` runs a scene: **time drops to 16% and ramps back over a second
and a half**, the arena clears, and the frame comes apart in seven layered
detonations 150ms apart, each with its own ring and its own shards. At 1.35s the
real shockwave goes — a white ring crossing the whole arena, a second slow, and
twenty pieces of hull thrown at 600px/s. The banner reads `TARGET DESTROYED`.
Its three cells are already on the floor before any of this starts.

Nothing may advance while it plays. A `sealing` flag holds the run open for
**3.1 seconds** before the wave-clear check is allowed to run, because without
it the arena is empty on the very next frame and the world map takes the screen
before the first detonation lands. The same hold defers a secret boss's
`missionEnd`. You keep control of the ship throughout.

**Dying gets the same treatment.** The run no longer ends on the frame your hull
hits zero. `deathFx()` slows time to a crawl, shatters the ship into shards,
walks four secondary detonations across the wreck and closes with a red ring the
size of the arena — and the results panel arrives **2.35 seconds later**, in a
new `dying` state that exists only to let the scene finish.

Both are built on one small fx layer next to `burst()`: `shock()` for expanding
rings, `shred()` for tumbling debris, `slow()` for time dilation, and `after()`
for scheduling a beat. Timers and the slow ramp run on **real** time, so a scene
plays at the same speed no matter how slow the world it is playing in.

## The Garage

Four hulls, pure stat trade-offs — no hidden rules. A hull is gated **twice**:
you have to have flown deep enough to unlock it, and then pay skill points for
it, so hulls compete with the Mindframe tree for the same currency.

| Ship | Class | HULL | POWER | RATE | SPEED | GRIP | Unlock |
|---|---|---|---|---|---|---|---|
| **LANCER** | Standard pattern | C | C | C | C | C | free |
| **BULWARK** | Assault hull | A | B | D | D | C | clear System 001 · 10 CR |
| **NEEDLE** | Interceptor | E | D | B | A | A | clear System 002 · 20 CR |
| **VERDICT** | Siege gunship | C | A | B | D | D | clear System 003 · 32 CR |

GRIP is handling — how hard the ship can push against its own drift. The letter
grades are *computed* from the multipliers rather than written by hand, so a
card can never lie about a ship. Each hull has its own silhouette in flight.

## Bestiary

Everything the game expects you to know lives on one tabbed screen — **HOSTILES**,
**CELLS**, and **CONTROLS** — reachable from the title screen and from the pause menu.

It is built as an **assess readout**, not a list: a roster down the left, and one
unit's full telemetry filling the panel on the right, inside a clipped-corner
frame with hairline rules, scanlines and a scan bar crawling down it.

The panel carries, for the selected unit:

- **The real silhouette**, live on its own canvas — rotating, breathing, inside
  a dashed target reticle and a grid. It is drawn by `unitPath()`, the *same*
  function the arena draws enemies with, so a codex entry can never show a shape
  the game does not actually field.
- **Five measured bars** — `HULL`, `VELOCITY`, `POWER`, `CADENCE`, `CONTACT` —
  each with its raw number beside it (`140`, `44 px/s`, `17 dmg`, `.37 /s`,
  `20 dmg`). Every bar is scaled against **the heaviest thing in the roster**
  rather than a hand-written maximum, so adding an enemy re-scales every card at
  once and no bar can quietly lie.
- **TACTICAL ANALYSIS** — what it is and how it behaves.
- **COUNTERMEASURE** — one line, in green, on how to actually kill it.

A hostile you have not met is not merely dimmed: its name renders as block
characters in the roster, and its panel reads `NOT YET ENCOUNTERED · TELEMETRY
UNAVAILABLE` with no silhouette and no bars. `CELLS` and `CONTROLS` use the same
frame with a cell casing in the art panel in place of a hull.

## Getting around

`Esc` backs out of any screen and pauses a run; `Enter` presses the main button
on whatever is in front of you. Once a run is under way the pause menu's
**QUIT TO TITLE** is the only way out of it — the briefing and the
between-systems map deliberately have none. `P` or `Esc` in flight opens a pause menu with
**RESUME**, the skill tree, the bestiary, and **QUIT TO TITLE** — quitting banks
your score and points and ends the run.

The skill tree is a screen you read and spend on, not a launch pad: it has no
launch button, only **BACK** to wherever you opened it from.

## The Mindframe tree

Credits buy skill points at the tree's **EXCHANGE** button, 2 credits to the
point. The tree stays locked until you first clear System 001, then opens
permanently — spend points, relaunch stronger, push deeper.
Tiers cost 2 / 4 / 7 points, so mastering all four branches takes several campaigns.
It is also reachable between systems, so points spent mid-run apply immediately.
The tree is drawn **bottom-up**: the first tier of each branch sits at the
bottom and the tier-3 skill at the top, so it grows upward as you buy into it.
Four branches of three:

- **Pulse Calibration → Focused Pulse → Phase Rounds** — damage, then piercing shots
- **Feed Overclock → Twin Emitters → Triple Spread** — fire rate, then a 3-shot spread
- **Hull Plating → Ablative Weave → Repair Field** — max HP, then passive regeneration
- **Thrust Vectoring → Blink Drive → Deflector** — speed, then a dash with i-frames

Buying a node is the only permanent thing in the game, so it lands like one: the
node overloads white and punches out a ring, the branch line feeding it surges,
the whole screen takes an inset green flare, and the skill's name and effect
stamp themselves over the tree for a second and a half. All CSS keyframes —
`nodeLand`, `lineSurge`, `screenPulse`, `stamp` — re-applied across the tree
rebuild by a `landed` marker, so the animation survives the redraw that follows
the purchase.

**RESPEC** sits beside `EXCHANGE`. It sells the entire tree back: every point
you ever spent on a skill returns, and every skill goes. It is free and total —
there is no tax and no partial refund — because points are the scarce thing and
a tree you regret is otherwise a save you cannot fix. The button shows what it
will refund (`RESPEC — REFUND 21P`), and a first click arms it into
`SELL 6 SKILLS FOR 21P?` for four seconds rather than firing straight away.
Hulls are bought with credits, so a respec never touches the Garage, and
lessons you have already flown stay flown.

Progress, points, best score and furthest wave persist in `localStorage`.

## Starting over

**WIPE ALL PROGRESS** is the last link on the title screen, in red. It is the
only genuinely destructive control in the game, so it names what it is about to
destroy before it will do it — a first click arms it into
`ERASE 41 CR · 6P · 4 SKILLS · 2 HULLS · BEST 18400? — CLICK AGAIN` for five
seconds. The second click clears the `localStorage` key outright and resets
credits, points, skills, hulls, best score, furthest system, and both tutorial
flags, so Pilot School opens itself again on the next load exactly as it does
for a new player.

## Save codes

**SAVE CODE** on the title screen shows a portable code for your progress —
credits, points, unlocked skills, unlocked hulls, best score and furthest system — as
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
