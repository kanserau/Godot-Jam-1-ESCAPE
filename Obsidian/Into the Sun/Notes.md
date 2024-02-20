I made some notes after going through the current iteration of the game.
Overall we should focus on implementing bug fixes, missing mechanics, and revising existing mechanics to be closer to the original plan.
# Changes to Occur
- Sounds need to be implemented and tested to ensure they blend together well
- Voice needs to be implemented and tested to make sure it's not annoying
- Most terminal commands shouldn't be terminal commands.
- Terminal failure needs to be implemented (this also doesn't need to show up in the alert feed as the alert feed would also fail)
- I will polish the existing tracks and aim to write a third track.
## game.tres
- Set target distance to 50,000
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
- Crowbar needs to move up with camera
- "Resolve" command should be named "Reboot"
- It's not very obvious that the left wall is a window, it just seems blank. Additionally, it seems to suggest that the ship's thruster is pointing parallel to the orbit path, as opposed to perpendicular.
- there is an infinite self-defib-exploit.
	- could be fixed by implementing secondary loss state (ship damage maxxed)
	- alternatively, implement terminal breakdown

## Space Debris & Solar Flares
- Solar flares when they hit should cause power outages and system failures.
- Space debris should hit a location, cause hull breaches, a chunk of ship damage, and high crew damage to any crew located there.
	- If space debris is location based, it should specify a location in the alert feed.
	- If teleport mechanic is implemented, this can be used as insurance against space debris.
- Screen shake when space debris or solar flare hits
## Terminals
Consider displaying multiple screens at once when interacting with the terminal.
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
## Bugs
- Sometimes defibbing breaks (captain, cook)
- ?Characters dying, but still displaying critical
- At some point events stop appearing in event feed, sometimes. Needs more testing.
- Terminal still works if power off.
- Character continues moving when opening the ESC menu.

## New Intro
Instead of launching the player right into the emergency, we can have a brief introduction.
This wouldn't be a tutorial per se, but it would allow the player a chance to familiarise themselves with the controls and ship systems.
Then, to begin the game, the engage the warp drive.
- Consider implementing warp VFX outside ship window.
