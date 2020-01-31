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
     --with Pre => Last_H <= 100 and Last_H >= 0 and H <= 100 and H >= 0
   is
   begin
      if Last_H >= H then
         Set_Message("Pump was active but humidity decreased.");
         return True;
      end if;
      return False;
   end Humidity_Checker_After;

   ----------------
   -- Tank_Update --
   ----------------

   procedure Tank_Update (V : Volume)
     --with Pre => Tank_Current <= Tank and V <= Tank and Tank_Current >= V,
     --     Post => Tank_Current'Old <= Tank_Current
   is
   begin
      Tank_Current := Tank_Current - V;
   end Tank_Update;

   ----------------
   -- Tank_Empty --
   ----------------

   function Tank_Empty return Boolean
     --with Post => Result = (Tank_Current = 0)
   is
   begin
      if Tank_Current = 0.0 then
         Set_Message("Tank is empty.");
         return True;
      else
         return False;
      end if;
   end Tank_Empty;

   -----------------
   -- Light_Check --
   -----------------

   procedure Light_Check (L : Brightness; Min : Brightness) is
   begin
      if L /= 0.0 and L < Min then
         Set_Message("Plant needs better exposure.");
      end if;
   end Light_Check;
end Checkers;
