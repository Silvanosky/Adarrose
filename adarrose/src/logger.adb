with Sensors;

package body Logger is
	Index : Natural := 0;

	Last_Time : Time := Clock;

	procedure ComputeStat is
	begin
		Light_Time := Seconds(0);
		for E in L_Vector.First_Index .. L_Vector.Last_Index  loop
			if L_Vector.Element(E) > Configs.Light then
				Light_Time := Light_Time + Configs.Refresh_Time;
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

			if H_Vector.Last_Index > Max_Values then
				H_Vector.Delete(0);
				L_Vector.Delete(0);
			end if;
		end if;
	end Update;
end Logger;
