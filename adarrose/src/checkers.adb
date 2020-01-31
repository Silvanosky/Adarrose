with Errors; use Errors;
with Configs; use Configs;

package body Checkers is

   ----------------------
   -- Humidity_Checker --
   ----------------------

   function Humidity_Checker return Boolean is
   begin
      if not Init_H then
         Init_H := True;
         Last_H := H;
         return False;
      end if;
      if P and Last_H > H then
         Set_Message("Punp active but humidity decreasing");
         return True;
      end if;
      return False;
   end Humidity_Checker;

   ----------------
   -- Tank_Empty --
   ----------------

   function Tank_Empty return Boolean is
   begin
      if False then
         Set_Message("Tank is empty");
         return True;
      else
         return False;
      end if;
   end Tank_Empty;

end Checkers;
