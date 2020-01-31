with Ada.Numerics; use Ada.Numerics;
with Checkers; use Checkers;

package body Decisions is

   -------------------
   -- Make_Decision --
   -------------------

   function Make_Decision (H : Humidity) return Time_Span
   is
      current : Time;
   begin
      if Tank_Empty then
         return Time_Span_Zero;
      end if;
      current := Clock;
      if Operating_Mode = Economy and current >= Day_Time.Start and current <= Day_Time.Stop then
         return Time_Span_Zero;
      elsif Operating_Mode = Scheduled and ((Schedule.Start <= Schedule.Stop and (current < Schedule.Start or current >= Schedule.Stop)) or (Schedule.Start > Schedule.Stop and (current <= Schedule.Start and current >= Schedule.Stop))) then
         return Time_Span_Zero;
      end if;
      return Compute_Time(Compute_Water(Plant_Pot, H) + Compute_Pipe);
   end Make_Decision;

   ------------------
   -- Compute_Time --
   ------------------

   function Compute_Time (Water : Volume) return Time_Span
   is
   begin
      return Milliseconds(Natural(Water) / Natural(Pump));
   end Compute_Time;

   -------------------
   -- Compute_Water --
   -------------------

   function Compute_Water (P : Plant; H : Humidity) return Volume is
   begin
      if P.Threshold <= h then
         return 0;
      else
         return Volume(Natural(P.Container) * Natural(P.Threshold - H) / 200);
      end if;
   end Compute_Water;
   
   ------------------
   -- Compute_Pipe --
   ------------------
   
   function Compute_Pipe return Volume is
   begin
      return Volume(Pipe.L * (Pipe.D / 2) * (Pipe.D / 2) *  Length(Pi) / 10);
   end Compute_Pipe;

end Decisions;
