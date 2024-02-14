# Concept
You're a newly minted technician working on a space vessel. You've just exited the warp too close to the sun. With your senior engineer dead and your captain already panicking, it's up to you to optimise the ship's systems to escape the sun's gravity well and get home safely.

The basically gameplay loop is about speed and efficiency whilst avoiding mistakes. 
# Winning & Losing
The player wins if he reaches the target distance from the sun. 
The player loses if he dies. Only 1 crew need to survive for a win (the player), as the ship has autopilot, and all repair systems are controlled from the engineer's room. He will have a hard time flying home though.
# Mechanics
## Digital Displays
### Crew Status Display
The Status Display is beside the Power Shunting Display and above the gauge rack.
- Lists all crew: Each member has a name, role and status.
	- Statuses
		- "Vitals normal." (before dropping warp)
		- "Distress detected." (after dropping warp)
		- "Deceased." (if dead)
	- E.g. "Rod Tungsten. Captain. Distress detected."
- Crew Names & roles
	- Captain Rod Tungsten
	- Pilot Ace Lander
	- Engineer (PLAYER NAME)
	- Chef Remy Martinez
	- Researcher Karl Langstrom
	- Medical Officer John Doctor
	- Gunner William Bannon
	- Second Technician Harold Tinner
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
- **Location**
	- "in crew quarters."
	- "in bridge."
	- "in engine room."
	- "in maintenance corridor."
	- "in cargo bay."
	- "in galley."
	- "in laboratory."
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
### Emergency Response Terminal
Use this display to respond to hull breaches and fires.
- A terminal used to type commands.
- Commands
	- "*Suppress*" + Location: Extinguishes fire at the location.
	- "*Repair*" + Location: Repairs hull breaches at the location.
	- Possible Locations:
		- crew quarters
		- bridge
		- engine room
		- maintenance corridor
		- cargo bay
		- galley
		- laboratory
	- "*Serve*" + Location: Provides drinks to personnel at the specified location. Captain dialogue if used on bridge.
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
- **Fuel Gauge**:
	- Displays ship's current fuel level from E to F.
	- Appearance: Like you would expect
	- Lore: Scans tank and calculates how much empty space vs. floating liquid there is.
	- Affected by THRUST LEVEL and EMERGENCIES (fuel leak)
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
	- The thrust must be kept in optimal cruise range (2 boxes) to ensure the fastest and safest escape from the sun. Low thrust is inefficient but allows for other systems to be boosted.  - both escape ETA and remaining fuel are displayed, however you must calculate (based on the manual's formula) how much actual time you have (there is a handy rough cheat sheet).
	- 3 boxes/levels of power.
	- Box 1: 1 thrust. (best cost) (maintains ship position)
	- Box 2: 4 thrust. (best efficiency) (positive vertical speed)
	- Box 3: 6 thrust. (best speed) (causes ship damage due to overheating) (double vertical speed)
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
	- 2 boxes: ON. Weapons active. Damages space debris.

## Maintenance
### SHIP INTEGRITY
Ship integrity is constantly declining due to the heat of the sun. Should be a high value like, 100k.
- This is a *hidden value*.
- It declines at a constant rate.
- The lower the ship integrity, the worse things get.
- Remaining ship integrity at the end contributes to score.
- Think of hull integrity as "the intensity at which shit goes wrong, when it goes wrong". It means that when bad things happen, they happen worse, if integrity is low.

## Emergencies
- There are three broad types of emergencies: System Failure, Structural Damage, and Internal Emergency.
- Emergencies happen at regular intervals and they cluster. This gives the player multiple problems to address at once and forces him to prioritise.
	- Think of a sine wave, where the problems happen in a clustered stagger toward the peak, then there's a bit of downtime in the troughs.
	- Ship integrity has the effect of causing a *greater number* of problems to occur in the peak.
- System failures are guaranteed to occur when the ship is hit with a solar flare. They can also happen randomly.
### System Failures
- **Generator Failure**: 
- **Electrical failure**: This causes a random system to stop working. Includes fire suppression, repair drones, thrusters, shields, life support.
	- **Engine Failure**: When thrusters fail they need to be rebooted.
	- **Oxygen Failure**: 
	- **Shield Failure**:
	- **Weapons Failure**
### Structural Damage
- **Hull breach**: These can occur at random points on the ship. When a hull breach is active, it nullifies life support until it's fixed. These must be fixed in a similar way to fire suppression, by locating the breach, and deploying structural foam.
### Internal Emergencies
- **Fire**
	- Fires occur at a random location.
	- Fire spreads to adjacent location if not suppressed quickly enough.
	- Fire damages crew members based on location:
		- crew quarters: medical officer
		- bridge: pilot
		- ==engine room: player (optional)==
		- maintenance corridor: technician
		- cargo bay: gunner
		- galley: chef
		- laboratory: researcher
		- Note: captain does not take damage from fire.
	- Fire reduces ship integrity
	- Fixed by entering correct command in terminal. (action and location must match)
- **Dead crew member**:
	- **Experience mode**: Ship integrity starts low declines faster for each dead crew member.
	- **Arcade mode**: Ship integrity starts high and declines more slowly for each dead crew member.

==Player Damage (optional)
Player damage is a unique emergency. While the player won't die from things that hurt them, they will become disorientated from things like pain, lack of oxygen, concussion, and so on.==
- ==Burns: Touching fire damages the player. This is the only source of damage.==
- ==Health is recovered over time==
- ==Oxygen deprivation: when oxygen is low, player's screen slowly fades to black.==