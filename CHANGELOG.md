# Changelog

## 1.1.0 — 2026-10-16

- **Starfarer, reworked:** enemy hull is down, and the bosses bring hazards
  instead. The Hive Mind's spore pods root into drifting green vents, 2117's
  phase change pulls you into its laser, the Architect's blast rings burst
  into debris, the Crescent's zoom fills the arena with low gravity, storm
  fronts roll in while the Titans stand, the Leviathan's head throws
  freezing glaciers, Omega's solar flares swell and split, and the Ruler and
  the Archive use any of them. The music turns slower and darker.
- **Galaxy marks:** a system held on Starfarer gets a gold galaxy on the map.
- **Music Sync (beta):** every boss fought to the music, with attacks on the
  beat and the punish window as a breakdown. The first LAUNCH asks if you
  want it on.
- **Feel:** punish hits knock the boss back; a hit shoves your ship (light
  hulls further, heavy hulls less) with a faint red pulse; your ship pulses
  blue when the dash is ready and in a powerup's colour when you take one.
- **Pause menu:** settings and the wipe are on a SETTINGS card, and MAIN MENU
  asks first. WIPE ALL PROGRESS now clears everything, settings included.
- **Controls:** ESC no longer goes back on menus, RETURN presses nothing, and
  a launch you have already watched can be skipped with a click.
- **Window size:** any window plays; a cramped one gets a hint on the menus.
- **Bosses:** retuned across the roster, no escort waves, and the Hive steers
  clear of vents.
- **Fixes:** the story's new fragment scrolls into view as it types, 2117's
  entrance scan lands on you, and a relaunch's launch can be skipped.
- The credits roll faster and end bigger.

## 1.0.0 — 2026-10-12

First release.

- **Campaign:** nine systems in three regions, from Earth to the Icarus, each
  with its own hazard, five waves and a boss. Cleared systems stay held.
- **Bosses:** authored attack lines, phase cutscenes, and a final fight behind
  the Ruler.
- **Side missions:** one off most systems, plus the Quantum Portal and its two
  secret bosses.
- **Progression:** credits, a four-branch skill tree, five hulls with
  upgrades, and medals with rewards.
- **Settings:** three difficulties, an effects setting (Full or Reduced),
  and save codes (`MF8`) to carry progress between browsers.
- **Extras:** bestiary, the story, and scrolling credits with gameplay
  screenshots, which also roll after the final fight.

### Since the last pre-release build

- The Icarus fields its own roster: Splinters, Zappers and Crushers.
- The Ruler has its own moves (Decree, Lash, Throne, Tether), and both Rulers
  have 25% more hull.
- MELTDOWN only kills outright with telegraphed attacks.
- Iteration 3296, the first boss, no longer summons escorts mid-fight, and
  Earth's boss wave sends no other enemies with it.
- The finale no longer summons echoes of earlier bosses.
- The finale Ruler's heartbeat glow now shows.
- Boss shapes animate at the same speed on 60 Hz and 120 Hz displays.
- Busy fights draw faster: glows are cached instead of redrawn every frame.
- Round numbers: a system pays 20, 30, 40 … 100 credits (boss bonus 8 → 10),
  side missions pay in fives, and skill cards show whole damage numbers.
- The Quantum Portal pays 55 for Iteration 3295 and 90 for the Archive, and
  each one's first win pays in full (beating 3295 used to cut the Archive's
  first reward to the repeat rate).
- Weapon Overclock and Twin Emitters are +20% fire rate each (they said 18%
  and actually gave 22%). Thrust Boost +20% speed (was 18%), Repair Field
  1.5 HP/s (was 1.4), Biological Weave −25% damage taken (was 22%).
- Flat skill bonuses are exactly what the card says on every hull: Hull
  Plating is +30 max HP, Pulse Upgrades +4 damage. They used to be scaled by
  the hull's multiplier (+28 HP on a Lancer, +44 on a Bulwark).
- Skill cards show fire rate and speed as the change (+20%) rather than raw
  shots or pixels a second.
- Medals open once Saturn is held, with a toast when they do; before that
  Medals & Rewards in Extras says when it opens.
- A system's boss reads UNKNOWN on its launch card and in the Bestiary until
  you beat it or lose to it.
- Locked side missions show ? ? ? on the map, like locked systems.
- The map's region arrow glows orange when a new region opens (after Saturn
  and after Sol) until you step into it.
- Map connector lines stop at the edge of each box.
- The result and launch cards scroll on short windows (1366×768 laptops
  could not reach SPACE MAP), and Enter continues from a result card.
- Dying to Splinter shrapnel names the Splinter and gives its tip.
- Resizing the window mid-flight (or leaving full screen) pauses the flight;
  the arena is a fixed size, so nothing about the fight changes.
- Opening another screen closes the Settings panel.
- The mouse aims and fires over the black bars beside the arena too; aim
  holds at the arena's edge instead of freezing.
- Buying a hull or a hull upgrade asks to confirm first, as the skill tree
  does.
- Medals that allow hits are "Steady", not "Flawless": Steady Jupiter, Steady
  Architect Battle, Steady Omega Space Station, Steady Ruler.
- The death screen's menu button always says MAIN MENU.
- Bestiary: the unit number is no longer squeezed under the header, and
  values like "78 px/s" stay on one line.
- The result screen is centred, and it and the launch screen start below the
  Settings gear.
- Locked skill cards read ACCESS DENIED.
- The game asks to be played full screen: anything smaller than (nearly) the
  whole display shows "Please play in full screen mode." with a FULL SCREEN
  button. A device with no mouse or trackpad (a phone, or a tablet on its own)
  gets "Please play on Desktop." instead; a tablet with a trackpad plays. In Chrome,
  Escape stays the pause key in full screen (hold it to leave).
- The corner markers on the home, launch, result and skill tree screens are gone.
- Score is gone. The result panels are replaced by two gold lines, Credits
  Earned and Total Credits (Boss Rush shows its time and best). The death
  screen keeps one line for how much hull a boss had left.
- The level complete, death and launch screens are flat black edge to edge,
  and level complete's SKILL TREE button is now MAIN MENU.
- Right click does what left click does everywhere: it fires in a fight and
  clicks buttons and cards. The browser's right-click menu no longer opens
  (except in the save code box, for pasting).
- A missing page element can no longer stop the script (and every button with
  it); a commit check refuses any version that would not load.
