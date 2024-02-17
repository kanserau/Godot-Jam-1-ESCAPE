# Concept
You're a newly minted technician working on a space vessel. You've just exited the warp too close to the sun. With your senior engineer dead and your captain already panicking, it's up to you to optimise the ship's systems to escape the sun's gravity well and get home safely.

The basically gameplay loop is about speed and efficiency whilst avoiding mistakes. 
# Winning & Losing
The player wins if he reaches the target distance from the sun. 
The player loses if he dies. Only 1 crew need to survive for a win (the player), as the ship has autopilot, and all repair systems are controlled from the engineer's room. He will have a hard time flying home though.
# Mechanics
## Movement
The rate at which the ship moves away from the sun is:
- **Vertical Speed** = THRUST - 100 in Units per Second.
	- Therefore at Thrust 1, ship remains still. At Thrust 2, ship advances at speed 300 (400-100). At thrust 3, ship advances at 500.
- **Target distance** = initial + 270,000 (this value can be modified to change the length of the game, at a rough rate of 18,000 per minute)
	- At a constant rate of speed 300, with a target of 270,000 ship will escape in 8 minutes.
	- It is likely the game will take longer, factoring in emergencies and their negative effect on thrust.
## Digital Displays
### Crew Status Display
The Status Display is beside the Power Shunting Display and above the gauge rack.
- Lists all crew: Each member has a name, ID, role, location, and status.
	- E.g. "Rod Tungsten. ID: 5781. Captain. Bridge. Distress detected."
	- Statuses
		- "Vitals normal." (before dropping warp)
		- "Distress detected." (after dropping warp)
		- "Critical." (defib window of 10s)
		- "Deceased." (if dead)
- Crew details
	- Rod Tungsten. ID: 0025. Captain. Bridge.
	- Ace Lander. ID: 1056. Pilot. Cockpit.
	- (PLAYER NAME). ID: 9989. Engineer. Engine room.
	- Remy Martinez. ID: 0871. Chef. Galley.
	- Karl Langstrom. ID: 0872. Researcher. Laboratory.
	- John Doctor. ID: 0067. Medical Officer. Crew quarters.
	- William Bannon. ID: 1234. Gunner. Cargo bay.
	- Harold Carter. ID: 9989. Second Technician. Maintenance corridor.
### Alert Feed
Lists emergencies and details, i.e type and location or affected system.
- Time displayed in 24hrs (optional). Each in-game minute is one second IRL.
	- "0600: "
	- "0745: "
- **Emergency Type**
	- "Fire" + Location
	- "Hull breach" + Location
	- "Engine failure detected."
	- "Atmosphere generator offline."
	- "Shield generator offline."
	- "Weapons offline."
	- "Solar flare detected. Impact in 10s."
	- "Debris detected. Impact in 10s."
- **Location**
	- "in crew quarters."
	- "in bridge."
	- "in engine room."
	- "in maintenance corridor."
	- "in cargo bay."
	- "in galley."
	- "in laboratory."
	- "in cockpit."
- **Examples**
- "1310: Fire detected in bridge."
- "0547: Hull breach detected in cargo bay."
- "0641: Shield generator offline."
### Power Shunting Display
- Displays the four core systems and their current power levels.
- Core systems status display. Each can be Green (Active), yellow (Investigate) or Red (ERROR)
	- Engine status
	- O2 Generator status
	- Shields status
	- Weapons status
### Command Terminal
Use this display to respond to hull breaches, fires, crew death, .
- A terminal used to type commands.
- Commands
	- "*suppress*" + Location: Extinguishes fire at the location.
	- "*repair*" + Location: Repairs hull breaches at the location.
		- Possible Locations:
			- cockpit
			- crew quarters
			- bridge
			- engine room
			- maintenance corridor
			- cargo bay
			- galley
			- laboratory
		- e.g. *repair crew quarters*
	- "*Reboot*": Followed by system requiring reboot.
		- e.g. *reboot weapons*
		- e.g. *reboot shield generator*
	- *Defib*: Followed by crew member ID. Revives crew member in critical condition.
		- e.g. *defib 0067*
	- "*Serve*" + Location: Provides drinks to personnel at the specified location. Captain dialogue if used on bridge.
		- e.g. *serve bridge*
## Analog Displays
### Gauge Rack
A horizontal rack of mechanical gauges that display various values. Read more below.
### Map of the Ship
It's a map of the ship. Just a basic poster.
## Gauge Rack
The gauge rack is horizontal, and below the power shunting and status displays.
Includes the following readings:
- **Altitude Indicator**:
	- Displays the ship's current distance from the sun.
	- Appearance: As per flight equivalent (altitude indicator)
	- Lore: Displays distance from nearest planetary object by measuring gravitational pull and comparing to a planetary database.
	- Has an INITIAL VALUE, affected by VERTICAL SPEED
- **Vertical Speed Indicator**:
	- Displays how quickly the ship is moving away from the Sun.
	- Appearance: As per flight equivalent (vertical speed indicator)
	- Lore: Works by measuring rate of change in gravitational pull. Useful for planetary takeoffs and landings.
	- Affected by THRUST LEVEL and ALTITUDE
- **Thrust Gauge**:
	- Displays current thrust level. 
	- Appearance: Like an RPM gauge. Green area indicates "efficient" usage. Red (above green) indicates "dangerous usage"
	- Affected by POWER SHUNTING (engine/thrust)
- **Oxygen Gauge**:
	- Displays current oxygen levels.
	- Appearance: Green area indicates "safe" levels. Red indicates unsafe levels, and is both above (toxic) and below (insufficient) the green.
	- Lore: complex atmospheric sensors
	- Affected by POWER SHUNTING (atmosphere generator) and EMERGENCIES (hull breach, fire)
## Power Shunting
From your **POWER SHUNTING DISPLAY** you'll shunt power to four systems:
The ship can output 400 power. Ship is at best efficiency at 300 power. I.e when life support is on and engines are at 200.
- The ship can output **4 boxes of power in total**.
	- Active boxes are blue.
	- Inactive boxes are not visible.
	- When at 5 boxes, additional boxes cannot be added until others are reduced (alternatively, new boxes are displayed red until other boxes are reduced, turning them blue)
	- There is no benefit to using less than maximum power.
- **The Engine** or **Thrust**
	- The thrust must be kept in optimal cruise range (2 boxes) to ensure the fastest and safest escape from the sun. Low thrust is inefficient but allows for other systems to be boosted. 
	- 3 boxes/levels of power.
	- Box 1: 100 thrust. (best cost) (maintains ship position)
	- Box 2: 400 thrust. (best efficiency) (positive vertical speed)
	- Box 3: 600 thrust. (best speed) (causes ship damage due to overheating) (double vertical speed)
- **Atmosphere Generator
	- The atmosphere generator optimises the ship's atmosphere and keeps it cool. In the event of a hull breach, it can raise oxygen levels. If oxygen levels are too high (left on too long), it can be deactivated. It can also fail and need manual rebooting, so keep an eye on it. If oxygen is too high or low, crew will suffer damage, risking death.
	- 2 boxes/levels of power.
	- 0 Boxes: Oxygen concentration is reduced.
	- 1 Box: Oxygen concentration is maintained.
	- 2 Boxes: Oxygen concentration is increased.
- **Shield Generator**
	- Shields protect your ship from damage. They use a lot of power, so they should only be used when absolutely necessary, and for as little time as possible (e.g. incoming debris, solar flare). While shields and the atmosphere generator are active, your ship can't generate enough thrust to escape, and will be pulled closer to the sun. While shields are active but life support isn't, your ship can maintain its position.
	- Either on or off.
	- 0 Boxes: OFF. Does nothing.
	- 2 Boxes: ON. Prevents damage from the sun and solar flares.
- **Weapons**
	- Used to destroy encroaching space debris. When active, will deplete space debris health.
	- 0 Boxes: OFF
	- 2 boxes: ON. Weapons active. Destroys space debris.

## Maintenance
### Ship Damage
Ship Damage is constantly caused by the heat of the sun.
- This is a *hidden value*.
- It increases at a constant rate.
- The higher the Ship Damage, the worse things get.
- Ship Damage at the end is subtracted from score.
- Think of ship as "the intensity at which shit goes wrong, when it goes wrong". It means that when bad things happen, they happen worse, if damage is high.
## Emergencies
- There are three broad types of emergencies: System Failure, Structural Damage, and Internal Emergency.
- All emergencies have a *WEIGHT VALUE*, which determines how likely it is to occur, relative to other emergencies.
- Emergencies happen at regular intervals and they cluster. This gives the player multiple problems to address at once and forces him to prioritise.
	- Think of a sine wave, where the problems happen in a clustered stagger toward the peak, then there's a bit of downtime in the troughs.
	- Ship Damage has the effect of causing a *greater number* of problems to occur in the peak.
- System failures are guaranteed to occur when the ship is hit with a solar flare. They can also happen randomly.
### System Failures
- **Power Generator Failure**: The generator can shut down as a random event, causing all terminals and lights to black out, creating an eerie dark silence.
	- Solution:
		- Use big primer (slow).
		- Turn ignition (takes a couple of seconds to start).
- **Electrical failure**: This causes a random system to stop working. Includes the engine, atmosphere generator, shields and weapons, as well as any terminal.
	- **Engine/thruster Failure**: Causes thrust to drop to 0. There are two types of failure: wiring and pneumatics.
		- Wiring Fault: Short circuits in the wiring prevents the thrusters from working.
			- Appearance: Sparking effect.
			- Sound: Electrical buzzing
			- Fix: Smack it with a crowbar. It just works.
		- Pipe broken: Gas leaks from broken/bent pipes causing the thrusters to work at 1% efficiency.
			- Appearance: Steam jets
			- Fix: Use crowbar to bend back into place.
	- **Atmosphere Generator Failure**: 
		- Ice on filter
			- Appearance: Ice on the exterior of the atmosphere generator.
			- Auditory: Cracking sound to indicate ice has formed
			- Fix: Use crowbar to smash ice a few times.
		- Pipe broken
			- Appearance: Pipe bent out of place, steam jet.
			- Auditory: Sound of hissing steam.
			- Fix: Use crowbar to bend back into place by hitting the pipe a few times.
	- **Shield Failure**:
		- Visual indicator: None.
		- Auditory indicator: Alarm sound.
		- Fix: Use terminal to reboot.
	- **Weapons Failure**
		- Visual indicator: None
		- Auditory indicator: Alarm sound.
		- Fix: Use terminal to reboot.
- **Terminal Failure**: Any of the electric terminals can fail, causing the player to lose access to its information and functions.
	- Visual: Terminal is blank or sparking if we use VFX.
	- Auditory: None or electrical buzzing
	- Fix: Whack the terminal with the crowbar a few times.
### Structural Damage
Physical damage to the ship that must be repaired.
- **Hull breach**: These can occur at random points on the ship. When a hull breach is active, it nullifies life support until it's fixed. These must be fixed in a similar way to fire suppression, by locating the breach, and deploying structural foam.
### Internal Emergencies
- **Fire**
	- Fires occur at a random location.
	- Fire spreads to adjacent location if not suppressed quickly enough.
	- Fire damages crew members based on location:
		- cockpit: pilot
		- crew quarters: medical officer
		- bridge: captain
		- ==engine room: player (optional)==
		- maintenance corridor: technician
		- cargo bay: gunner
		- galley: chef
		- laboratory: researcher
	- Fire causes Ship Damage
	- Fixed by entering correct command in terminal. (action and location must match)
- **Dead crew member**:
	- **Experience mode**: Ship Damage increases faster for each dead crew member.
	- **Arcade mode**: Ship Damage increases more slowly for each dead crew member.

==Player Damage (optional)
Player damage is a unique emergency. While the player won't die from things that hurt them, they will become disorientated from things like pain, lack of oxygen, concussion, and so on.==
- ==Burns: Touching fire damages the player. This is the only source of damage.==
- ==Health is recovered over time==
- ==Oxygen deprivation: when oxygen is low, player's screen slowly fades to black.==

### Master Emergency List
A list of every possible emergency.
- Power generator failure
- Engine wiring fault
- Engine piping damage
- Atmosphere generator icing
- Atmosphere generator piping damage
- Shield failure
- Weapons failure
- Crew status display failure
- Alert feed failure
- Power shunting display failure
- Emergency response/command terminal failure
- Fire
- Hull breach
- Solar flare
- Space debris




# Values Likely to be Changed
This is a list of all values that I would like to be able to tweak before releasing.
- Major values
	- Target distance (the win condition)
	- Ship Damage (starts at 0 and increases)
		- Ship Damage RATE multiplier (i.e the extent to which Ship Damage affects the emergency cluster frequency)
		- Ship Damage QUANTITY multiplier (i.e the extent to which Ship Damage affects the number of emergency per cluster)
	- Emergency cluster frequency
	- number of emergencies per cluster
	- Sun damage to Ship Damage (or passive Ship Damage rate)
- Movement Values
	- Sun's gravity (negative thrust generated by the sun). Has two values:
		- Initial value
		- Value at target distance
	- Thrust values
		- At 1 box
		- At 2 boxes
		- At 3 boxes
- Emergency Values: The time the player has to respond to certain emergencies
	- Solar flare countdown value (time until solar flare hits the ship)
	- Space debris countdown value (time until space debris hits the ship)
	- Fire spread rate (time it takes for fire to spread to adjacent rooms)
	- Crew damage caused by fire
	- Ship damage caused by fire
	- Hull breach damage to Ship Damage
	- Oxygen depletion and regeneration rates (additive)
		- Oxygen depletion rate from disabled atmosphere generator
		- Oxygen depletion rate from hull breach
		- Oxygen regeneration rate (atmosphere generator at 2 boxes)
	- Crew Health (damage required to kill a crew member)
	- Crew defib window (time the player has to defib a crew member before they die)
- Emergency Weights (the value that decides the chance of an emergency occurring relative to others). See the master emergency list above.
- Repair values
	- Time to prime power generator
	- Time to start power generator with ignition
	- Number of crowbar hits required to reboot terminal