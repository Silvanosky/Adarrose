with Ada.Real_Time; use Ada.Real_Time;
with Checkers; use Checkers;
with Computes; use Computes;
with Configs; use Configs;
with Pump;

package body Decisions is

	Last_Time : Time := Clock;
	--------------
	-- Decision --
	--------------

	procedure Decision (Pip : Cylinder; H : Humidity; L : Brightness; LT : Brightness; P : Plant; Pum : Debit; Sched : Scheduler) is
		Current : Time := Clock;
		Timer : Time_Span := Time_Span_Zero;
		B : Boolean := True;
	begin
		if Last_Time + Configs.Refresh_Time < Clock then
			if not Done and not Tank_Empty then
				if Operating_Mode = Continous then
					Timer := Compute(Pip, H, P, Pum);
				elsif Operating_Mode = Economy and L <= LT then
					Timer := Compute(Pip, H, P, Pum);
				elsif Operating_Mode = Scheduled and ((Sched.Start < Sched.Stop and (Current >= Sched.Start and Current <= Sched.Stop)) or (Sched.Start > Sched.Stop and (Current >= Sched.Start or Current <= Sched.Stop))) then
					Timer := Compute(Pip, H, P, Pum);
				elsif Operating_Mode = Punctual then
					Timer := Compute(Pip, H, P, Pum);
					Done := True;
				end if;
				Humidity_Checker_Before;
				Pump.Run(Timer);
				B := Humidity_Checker_After;
			end if;
			Last_Time := Clock;
		end if;
	end Decision;

end Decisions;
