Welcome to the Into the Sun game manual. We didn't have time to make a tutorial, so you get this instead.

To win, you need to get away from the Sun, which is quickly and painfully melting your ship and crew. From the engine room, you'll fix pretty much everything that can go wrong both near and far.
# The Engine Room
In the engine room you'll find a computer terminal, the engine, atmospheric pipes, and the power reset button. Many of these will break frequently, and need to be fixed. You can do so by using the **multitool**. Sometimes hazards like fires will appear - you can deal with these using your **multitool**.
## The Computer Terminal
These terminals display all relevant information and allow you to interact with the ship in various ways.
- The alert feed will display any problems you need to deal with and where that problem is located. Make sure to keep an eye on it.
- The crew status display will give you relevant information about the crew, such as where they are, their identity, and whether they're alive or not. 
- The power shunting terminal will allow you to divert power to different ship systems.
- The command terminal will allow you to deal with problems in other areas of the ship remotely.
### Power Shunting
You can route or divert power from various systems by interacting with this terminal. The ship has a power supply of 4 units.
- **Thrust**: The engine has three levels of thrust, costing 1, 2 and 3 power. 1 power is the least efficient, and 2 and 3 power are both equally efficient.
- **Atmosphere Generator**: The atmosphere has two levels of power. At 1 power, oxygen levels are maintained. At 2 power, oxygen levels increase. You need to make sure oxygen levels stay in the safe zone.
- **Shield Generator**: This one is either on or off, and consumes 2 power. You'll need this to protect from solar flares.
- **Weapons**: These are also either on or off, and consume 2 power. You'll need these to protect from stray space debris.
### Terminal Commands
- help - Display a list of commands
- info - Displays information about the ship including:
	- Ship distance/escape progress
	- Ship integrity
	- Current oxygen levels
	- Number of active emergencies
	- Number of location based emergencies
- locations - Displays a list of game locations for fire and breach handling.
	- cockpit
	- crew quarters
	- bridge
	- engine room
	- maintenance corridor
	- cargo bay
	- galley
	- laboratory
- crew - displays crew details
- defib [crew member ID] - Revive a crew member at critical condition.
- reboot [system] - Restore a failed system. Works on weapons or power.
- suppress [location] - Extinguish all fire at a given location.
- repair [location] - Repair all hull breaches at a given location. See above for options.
### Common Emergencies
Here's a list of things that commonly go wrong, and how to fix them:
- **Fire**: Fire will damage the ship, the crew, and deplete oxygen.
	- Fix: Use the suppress command on the terminal.
	- Note: There's no suppression in the engine room, so you'll need to use the multitool.
- **Hull breaches**: Ship damage and rapid oxygen loss.
	- Fix: Use the repair command on the terminal.
	- Note: The engine room is extra reinforced and won't experience hull breaches.
- **Dangerous oxygen levels**: If oxygen levels are too high or low, the crew will take damage.
	- Fix: Adjust the atmosphere generator in the power shunting terminal.
- **Broken terminal/engine/atmos gen/engine room fire**: Use the multitool in the engine room.
- **Failed shield generator/weapons**: This will prevent you from shunting power to the relevant system.
	- Fix: Use the reboot command on the terminal.
	- Note: You will need to shunt power again manually.
- **Crew member in critical condition**: Crew members with a health status of 25% or below are in critical condition, and very close to dying.
	- Fix: Use the defib command on the terminal. Be quick about it.
	- Note: A deceased crew member cannot be defibrillated. If you lose all of your crew, it's over.
	- Note: You can't defib a crew member with a health status more than 25%.
- **Solar flare**: If a solar flare hits the ship, it'll cause significant damage to the ship.
	- Fix: Divert power to the shield generator for protection.
- **Space debris**: If space debris hits the ship, it'll cause significant damage to the ship.
	- Fix: Divert power to weapons for protection.
## Things to Remember
If in doubt, use the **multitool**.
Keep an eye on the **alert feed** and **crew status display**.