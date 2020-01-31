with Types; use Types;

package Checkers is

   Init_H : Boolean := False;
   Last_H : Humidity;
   Tank_Current : Volume := 100.0;

   procedure Humidity_Checker_Before;
   function Humidity_Checker_After return Boolean; -- True = Error
   procedure Tank_Update (V : Volume);
   function Tank_Empty return Boolean;
   procedure Light_Check (L : Brightness; Min : Brightness);

end Checkers;
