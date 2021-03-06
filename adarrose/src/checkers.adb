with Errors; use Errors;
with Sensors; use Sensors;

package body Checkers is

   -----------------------------
   -- Humidity_Checker_Before --
   -----------------------------

   procedure Humidity_Checker_Before is
   begin
         Last_H := H;
   end Humidity_Checker_Before;

   ----------------------------
   -- Humidity_Checker_After --
   ----------------------------

   function Humidity_Checker_After return Boolean
   is
   begin
      if Last_H >= H then
         Set_Message(2);
         return True;
      end if;
      return False;
   end Humidity_Checker_After;

   ----------------
   -- Tank_Update --
   ----------------

   procedure Tank_Update (V : Volume)
   is
   begin
      Tank_Current := Tank_Current - V;
   end Tank_Update;

   ----------------
   -- Tank_Empty --
   ----------------

   function Tank_Empty return Boolean
   is
   begin
      if Tank_Current = 0.0 then
         Set_Message(3);
         return True;
      else
         return False;
      end if;
   end Tank_Empty;

   -----------------
   -- Light_Check --
   -----------------

   procedure Light_Check (L : Brightness; Min : Brightness)
   is
   begin
      if L /= 0 and L < Min then
         Set_Message(4);
      end if;
   end Light_Check;
end Checkers;
