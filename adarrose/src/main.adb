with Configs; use Configs;
with Decisions; use Decisions;
With Errors; use Errors;
with Plants; use Plants;
with Sensors; use Sensors;
with Pump; use Pump;
with Types; use Types;
with Screen; use Screen;

with Ada.Real_Time; use Ada.Real_Time;

procedure Main
is

begin
	Screen.Init;
	Sensors.Init;
	Pump.Init;

	loop
		Sensors.Update;
		delay until Clock + Milliseconds(10);

		Screen.Print;

		delay until Clock + Milliseconds(200);
	end loop;
end Main;

