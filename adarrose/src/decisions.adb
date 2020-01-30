with Errors; use Errors;

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
      elsif Operating_Mode = Scheduled then
         return Time_Span_Zero;
      elsif Operating_Mode = Spot and not Bastle then
         return Time_Span_Zero;
      end if;
      return Compute_Time(Compute_Water(Plant_Pot ,H));
   end Make_Decision;

   ------------------------
   -- Compute_Time --
   ------------------------

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
         return Volume(Natural'Val(P.Container) * Natural'Val(P.Threshold - H) / 200);
      end if;
   end Compute_Water;

end Decisions;
