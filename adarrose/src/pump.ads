with Ada.Real_Time; use Ada.Real_Time;
with Types; use Types;

package Pump is

	procedure Init;
	procedure Run (Time : Time_Span);

end Pump;
