# Core Mechanics
## Winning and Losing
**Win**
- Player wins if
	- Distance from sun = target value
**Loss**
- Player loses if:
	- He dies

**Score**
- [ ] Score is affected by:
	- Time taken to escape the Sun (subtracted)
	- Crew Remaining (added)
	- Ship integrity remaining (added)

**Crew Damage**
- [ ] Crew Damage is accrued from certain states and at different rates.
	- Inactive Oxygen
	- Fire in bridge (other locations don't count)
	- Low oxygen (damage inverse to oxygen levels)
	- Vacuum
- [ ] Crew Damage, when not being gained, is lost at a fixed rate
- [ ] When Crew Damages reaches a threshold, Crew Count decreases, and crew damage resets

**Power**
- [ ] Power implemented
- When power is active, systems function. Power is required for Thrust, Oxygen, Shields, Weapons, Fire Suppression, and so on.
- If power fails, all systems deactivate after a few seconds

**Displays**
- [ ] ANALOG DISPLAY/Gauges (horizontal rack)
	- Altitude Indicator
	- Vertical Speed Indicator
	- Fuel Gauge
	- Thrust Gauge
	- Oxygen Gauge
- [ ] DIGITAL DISPLAY/Screens
	- Status Display
		- Crew count
		- Alert feed
	- Power shunting screen
	- Crew Count, displayed as a fraction
	- Engine status (Active, Inactive, Failure)
	- Shields status (Active, Inactive, Failure)
	- Weapons status (Active, Inactive, Failure)

**Power Shunting**
- [ ] Power shunting interface
- [ ] Power implemented
	- % of power used depletes fuel at a given rate
	- power to fuel ratio becomes less efficient as more power is used (or rather there is an optimal power level, and too low is bad too)
- [ ] Player can shunt power to four separate systems within the power shunting interface. 
	- [ ] Thrust/engine
	- [ ] Oxygen.
	- [ ] Shields.
	- [ ] Weapons. Consumes moderate power. Causes damage to space debris.

Ship Integrity
- Rate of emergencies increases proportionally inverse to ship integrity
- Ship integrity decays if damaged
	- decays constantly based on proximity to the sun
	- decays if there is a fire
	- decays if there is a hull breach
- At certain intervals, emergencies occur. Emergencies are random.

Emergencies
- Engine Failure: overheating
- Engine failure: oil leak
- Engine failure: fuel leak
- Oxygen failure
- Shield failure
- Hull Breach
- Fire
	- Fire is assigned a location
	- Fire accrues Crew Damage
- Hull breach
- Engine failure
- Oxygen
- Shields failure
- 

**Events**
- [ ] At fixed intervals, a solar flare occurs.
	- [ ] This is preceded by a warning that provides just enough time to get failed shields running.
- [ ] Solar flare can be stopped with Shields
- [ ] A solar flare that isn't stopped causes SIGNIFICANT ship integrity loss
- [ ] Space Debris

# Other
## The Manual
This is all the player gets for a tutorial. It tells the player:
- 