Core Mechanics
**Victory**
- Player wins if
	- Distance from sun = target value.
	- Bonus: Fuel is enough to reach home
**Loss**
- Player loses if:
	- Crew count reaches 1
	- Fuel reaches 0 (AND there is not enough momentum to escape the gravity well)
	- Ship Integrity reaches 0

**Score**
- [ ] Score is affected by:
	- Total time to escape the Sun (subtracted)
	- Crew Count (added)
	- Fuel remaining (added)
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

**Ship Status**
- [ ] Ship status display - uses analog gauges
	- Altitude. It's an analogue gauge that displays the distance from the nearest celestial object, or strongest gravity well. Uses complex sensors.
	- Vertical Speed. Another analogue gauge that displays change in altitude, positive or negative. (calculated via changes in gravitational energy)
	- Current thrust value (green area signifies most efficient, yellow for inefficient, red for danger zone)
	- Remaining fuel / fuel gauge. 
	- Crew Count, displayed as a fraction
	- Engine status (Active, Inactive, Failure)
	- Oxygen status (Active, Inactive, Failure)
	- Shields status (Active, Inactive, Failure)
	- Weapons status (Active, Inactive, Failure)

**Power Shunting**
- [ ] Power shunting interface
- [ ] Power implemented
	- % of power used depletes fuel at a given rate
	- power to fuel ratio becomes less efficient as more power is used (or rather there is an optimal power level, and too low is bad too)
- [ ] Player can shunt power to four separate systems within the power shunting interface. 
	- [ ] Thrust. Modifies ship speed. Thrust consumes power and generates heat. If too high, reduces ship integrity.
	- [ ] Oxygen. Should always be active. While inactive, causes Crew Damage, which kills crew if it gets too high.
	- [ ] Shields. Consumes significant power. Protects from heat spikes/solar flares from the sun.
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