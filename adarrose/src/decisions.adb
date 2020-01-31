with Ada.Real_Time; use Ada.Real_Time;
with Checkers; use Checkers;
with Computes; use Computes;
with Configs; use Configs;

package body Decisions is

   --------------
   -- Decision --
   --------------

   procedure Decision (Pip : Cylinder; H : Humidity; L : Brightness; LT : Brightness; P : Plant; Pum : Debit; Sched : Scheduler) is
      Current : Time := Clock;
      Timer : Time_Span := Time_Span_Zero;
   begin
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
         -- Call executionner
      end if;
   end Decision;

end Decisions;
