with Types; use Types;
with Ada.Real_Time; use Ada.Real_Time;

package Pump is

	procedure Init;
	procedure Run (Time : Time_Span);

end Pump;
