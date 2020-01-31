with Sensors;
with Configs;

with Ada.Real_Time; use Ada.Real_Time;

package body Logger is
	Index : Natural := 0;

	Last_Time : Time_Span := Clock;

	procedure ComputeStat is
	begin
		Light_Time := 0;
		for E of L_Vector loop
			if L_Vector(E) > Configs.Light then
				Light_Time := Light_Time + Configs.Refresh_Time
			end if;
		end loop;

	end ComputeStat;

	procedure Update is
	begin
		if Last_Time + Configs.Refresh_Time < Clock then
			if Index >= 23 then
				Index := 0;
			else
				Index := Index + 1;
			end if;

			H_Vector.Append(Sensors.H);
			L_Vector.Append(Sensors.L);

			ComputeStat;
			Last_Time := Clock;

			if H_Vector.Last_Index > Seconds(86400) / Configs.Refresh_Time then
				H_Vector.Delete(0);
				L_Vector.Delete(0);
			end if;
		end if;
	end Update;
end Logger;
