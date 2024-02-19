Style notes:
- display ship distance as %
- display ship damage as %
- display time survived

Teleport:
- Changes a crew member's location.
- Crew members in the same room as the medical officer heal passively
- Crew members automatically return to station once healed

Note
- there is an infinite self-defib-exploit.
 - could be fixed by implementing secondary loss state (ship damage maxxed)
 - alternatively, implement terminal breakdown

Bugs
- Sometimes defibbing breaks (captain, cook)
- ?Characters dying, but still displaying critical
- At some point events stop appearing in event feed, sometimes. Needs more testing.
- Terminal still works if power off.