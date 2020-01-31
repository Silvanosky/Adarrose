with Checkers; use Checkers;
with Computes; use Computes;
with Configs; use Configs;
with Decisions; use Decisions;
With Errors; use Errors;
with Pump; use Pump;
with Screen; use Screen;
with Sensors; use Sensors;
with Types; use Types;
with Logger;

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
		Logger.Update;
                Screen.Print;
                Decision(Pipe, Sensors.H, Sensors.L, Light, Plant_Pot, Configs.Pump, Schedule);

		delay until Clock + Milliseconds(200);
	end loop;
end Main;

