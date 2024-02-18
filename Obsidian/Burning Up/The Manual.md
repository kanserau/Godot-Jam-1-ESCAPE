Welcome to the Into the Sun game manual. We didn't have time to make a tutorial, so you get this instead.

To win, you need to get away from the Sun, which is quickly and painfully melting your ship and crew. From the engine room, you'll fix pretty much everything that can go wrong both near and far.
# The Engine Room
In the engine room you'll find a set of computer terminals, a set of informative gauges, atmosphere generator piping, and of course the engine. These can all break and may need to be fixed. You can do so by using the **multitool**. Sometimes, fires will appear - you can also put out fires using the **multitool**.
## Gauges
These analogue gauges don't fail, and they display important information.
- **Altitude indicator**: This displays your current distance from the nearest planetary object.
- **Vertical speed indicator**: This displays your current vertical speed, or the rate at which you're moving away from the nearest planetary object.
- **Thrust gauge**: This displays how much thrust you're currently generating.
- **Oxygen gauge**: This displays the current level of oxygen in the atmosphere. Be sure to keep this in the 'green' zone.
## Computer Terminals
These terminals display all relevant information and allow you to interact with the ship in various ways.
- The alert feed will display any problems you need to deal with and where that problem is located. Make sure to keep an eye on it.
- The crew status display will give you relevant information about the crew, such as where they are, their identity, and whether they're alive or not. 
- The power shunting terminal will allow you to divert power to different ship systems.
- The command terminal will allow you to deal with problems in other areas of the ship remotely.
### Power Shunting
You can route or divert power from various systems by interacting with this terminal. The ship has a power supply of 4 units.
- **Thrust**: The engine has three levels of thrust, costing 1, 2 and 3 power. 1 power is the least efficient, and 2 and 3 power are both equally efficient, but the excessive heat generated at 3 power causes damage to the ship.
- **Atmosphere Generator**: The atmosphere has two levels of power. At 1 power, oxygen levels are maintained. At 2 power, oxygen levels increase. You need to make sure oxygen levels stay in the safe zone.
- **Shield Generator**: This one is either on or off, and consumes 2 power. You'll need this to protect from solar flares.
- **Weapons**: These are also either on or off, and consume 2 power. You'll need these to protect from stray space debris.
### Terminal Commands
- help - display a list of commands
- defib [ID] - Revive a crew member. Use the crew member's 4-digit ID.
- suppress [location] - Extinguish all fire at a given location. Options include:
	- cockpit
	- crew quarters
	- bridge
	- engine room
	- maintenance corridor
	- cargo bay
	- galley
	- laboratory
- repair [location] - Repair all hull breaches at a given location. See above for options.
- reboot [system] - Restore a failed system. Options include:
	- weapons
	- shield generator
- serve [location] - Serve refreshments to any crew at a given location. See above for options.
### Common Emergencies
Here's a list of things that commonly go wrong, and how to fix them:
- **Fire**: Fire will damage the ship, the crew, and deplete oxygen. Fix: Use the suppress command on the terminal. Note: There's no suppression in the engine room, so you'll need to use the multitool.
- **Hull breaches**: Ship damage and rapid oxygen loss. Fix: Use the repair command on the terminal. Note: The engine room is extra reinforced and won't experience hull breaches.
- **Dangerous oxygen levels**: If oxygen levels are too high or low, the crew will take damage. Fix: Adjust the atmosphere generator in the power shunting terminal.
- **Broken terminal/engine/atmos gen/engine room fire**: Use the multitool in the engine room.
- **Failed shield generator/weapons**: Use the reboot command on the terminal.
- **Crew member in critical condition**: Use the defib command on the terminal. Be quick about it. A deceased crew member cannot be defibrillated. If you lose all of your crew, it's over.
- **Solar flare**: If a solar flare hits the ship, it'll cause significant damage to the ship. Fix: Divert power to the shield generator for protection.
- **Space debris**: If space debris hits the ship, it'll cause significant damage to the ship. Fix: Divert power to weapons for protection.
## Things to Remember
If in doubt, use the **multitool**.
Keep an eye on the **alert feed** and **crew status display**.