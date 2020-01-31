with Ada.Real_Time; use Ada.Real_Time;
with Types; use Types;

package Pump is

	procedure Init;
	procedure Run (T : Time_Span);

end Pump;
