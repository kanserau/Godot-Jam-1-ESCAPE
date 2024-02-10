You're a newly minted technician working on a space vessel. You've just exited the warp too close to the sun. With your senior engineer dead and your captain already panicking, it's up to you to optimise the ship's systems to escape the sun's gravity well and get home safely.

The basically gameplay loop is about speed and efficiency whilst avoiding mistakes. 

# Mechanics
## Power Shunting
From your Systems Interface you'll shunt power to four systems:
The ship can output 400 power. Ship is at best efficiency at 300 power. I.e when life support is on and engines are at 200.
- **Thrust**
	- The must be kept in optimal cruise range to ensure the fastest escape from the gravity well. The more thrust, the better your ETA, but the sooner your fuel will run out - both escape ETA and remaining fuel are displayed, however you must calculate (based on the manual's formula) how much actual time you have (there is a handy rough cheat sheet).
	- Costs 300 Power at 100%.
- **Life Support**
	- Deactivating or lowering life support can save power, but will kill a crew member if inactive for too long, and disorient the player. It can also fail and need manual rebooting, so keep an eye on it. Ship performance will drop for each crew member lost.
	- Either on or off.
	- Costs 100 Power when on.
- **Shields**
	- Shields protect your ship from damage. They use a lot of power, so they should only be used when absolutely necessary, and for as little time as possible (e.g. incoming debris, solar flare). While shields and life support are active, your ship can't generate enough thrust to escape, and will be pulled closer to the sun. While shields are active but life support isn't, your ship can maintain its position.
	- Either on or off.
	- Costs 200 power when on.
- **Weapons**
	- You won't be needing these, so keep the power low (shunting power here won't help you, but it will reduce available power, and it will make the captain yell at you).
	- Costs 1 Power

## Emergencies
There are three broad types of emergencies. System Failure, Structural Damage, and Internal Emergency. System failures are likely to occur when the ship is hit with a solar flare.
While shields are not active, your ship is taking constant damage. While shields are active, your ship can only power the thrusters enough

System Failures
- Engine Failure
	- The engine can fail for different reasons. The reason affects the solution.
		- Overheating: Emergency cooling required. Indicated by smoke.
		- Oil/fuel leak: Indicated by BLACK or CLEAR liquid pooling. Repairs required. If player forgets gloves.
		- 
- Life Support Failure
	- Life support failure prevents life support from activating.
- Shield Failure.
	- A shield failure prevents the shield from activating. It causes a specific alarm to blare and a blue light to flash.

Structural Damage
- Hull breach: These can occur at random points on the ship. When a hull breach is active, it nullifies life support until it's fixed. These must be fixed in a similar way to fire suppression, by locating the breach, and deploying structural foam.
- Electrical failure: This causes a random electrical system to stop working. Includes fire suppression, structural foam, shields, life support.

Internal Emergencies
- Crew member dead
	- When a crew member dies, the ship suffers a random debuff from a limited list and a unique announcement is made. If all crew members die, it's game over.
	- Dead pilot: Reduced thrust performance.
	- Dead scientist: Increased Shield power drain.
	- Dead captain: The last crew member to die. Game over.
	- Dead technician: Reduced 
	- Dead gunner: Nothing happens. Padding.
- Fire
	- Fire causes damage to crew. Fire must be isolated, then active fire suppression used. Using fire suppression in the incorrect location means the fire continues, and the fire suppression must recharge. Infinite uses.

Player Damage
Player damage is a unique emergency. While the player won't die from things that hurt them, they will become disorientated from things like pain, lack of oxygen, concussion, and so on.
- Burns: Touching hot parts without switching to gloves. Burns disorient with colour.
- Oxygen deprivation: When life support is disengaged or there's a hull breach, player might suffer a lack of oxygen, which disorients the player.


# Scenes
- game starts in the warp
- captain saying one of a few random introductions