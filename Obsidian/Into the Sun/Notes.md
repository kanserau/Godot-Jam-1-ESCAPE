I made some notes after going through the current iteration of the game.
Overall we should focus on implementing bug fixes, missing mechanics, and revising existing mechanics to be closer to the original plan.
# Changes to Occur
- Sounds need to be implemented and tested to ensure they blend together well
- Voice needs to be implemented and tested to make sure it's not annoying
- Most terminal commands shouldn't be terminal commands.
- Terminal failure needs to be implemented (this also doesn't need to show up in the alert feed as the alert feed would also fail)
- I will polish the existing tracks and aim to write a third track.
## game.tres
- [x] Set target distance to 50,000
- [x] Disable damage from thrust level 3 (not needed)
## Style notes
### Ending Screen
- display ship distance as %
	- stretch goal: consider displaying distance visually as well
- replace SHIP DAMAGE with SHIP INTEGRITY and display as %
	- only player facing is necessary
- Display time survived
- Considering adding 'endings' based on which crew are alive/dead when the player dies.
- Consider animating the background?
### Fixes/problems
- [x] Crowbar needs to move up with camera
- [x] "Resolve" command should be named "Reboot"
- [ ] Indicate weapons / shields requires 2 units
- [ ] increase multitool volume
- [ ] Lag when loading main scene
- [ ] Lag when light turns off?
- [ ] player stuck?
- [ ] tutorial
- [ ] power shunting buttons +/-
- [ ] subtitles
- [ ] Terminal - highlight if input is not focused
-  It's not very obvious that the left wall is a window, it just seems blank. Additionally, it seems to suggest that the ship's thruster is pointing parallel to the orbit path, as opposed to perpendicular.
- there is an infinite self-defib-exploit. Potential fixes:
	- implement secondary loss state (ship damage maxxed)
	- implement terminal breakdown
	- prevent defib from working on crew still taking damage
	- add defib cooldown per crew member
	- defib costs one power
### How to Play
- how to play option in the menu
- list of controls, explanation of the game flow
- in as few words as possible

### Alert Feed
- Similar events should be grouped
- Every 10% loss of ship integrity should be displayed as a warning
	- Warning: ship integrity at 90%
## Space Debris & Solar Flares
- Solar flares when they hit should cause power outages and system failures.
- Space debris should hit a location, cause hull breaches, a chunk of ship damage, and high crew damage to any crew located there.
	- If space debris is location based, it should specify a location in the alert feed.
	- If teleport mechanic is implemented, this can be used as insurance against space debris.
- Screen shake when space debris or solar flare hits
## Terminals
- [x] Consider displaying multiple screens at once when interacting with the terminal.
## Crew Healing
I think crew should be able to heal, since currently the only way to recover crew is to wait until they're critical and then defib them. This could be passive, or by having a teleport mechanic to move people around the ship.
### Passive Implementation
- Crew should heal slowly and only when not taking damage from any source.
### Teleport
Consider implementing a command to move crew members around the ship.
- Changes a crew member's location.
- Crew members in the same room as the medical officer heal passively
- Crew members automatically return to station once healed
- To avoid sticking all crew members in the healing area and leaving them there, there are a few solutions:
	- Give each room a crew capacity
	- Give each room a function which is lost without the crew member there

### Treat Command
If the Medical Officer is not in critical condition or dead, you can use this command on a location. After a delay, the character at the location is treated by the Medical Officer, healing to full health.
- The treat command has a cooldown.


## Bugs
- [x] Sometimes defibbing breaks (captain, cook)
- [x] ?Characters dying, but still displaying critical
- At some point events stop appearing in event feed, sometimes. Needs more testing.
- [x] Terminal still works if power off.
- [x] Character continues moving when opening the ESC menu.

## New Intro
Instead of launching the player right into the emergency, we can have a brief introduction.
This wouldn't be a tutorial per se, but it would allow the player a chance to familiarise themselves with the controls and ship systems.
Then, to begin the game, the engage the warp drive.
- Consider implementing warp VFX outside ship window.


## Repair Methods
#stage3
### The Engine
- #stage2 The engine has multiple repair points.
	- 2 ground floor
	- #stage3 2 top floor
- All repair points must be repaired to fix the engine, one interaction each.
- #stage2 The engine can fail multiple times, each triggering another repair point