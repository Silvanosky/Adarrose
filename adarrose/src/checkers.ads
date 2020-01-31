with Types; use Types;

package Checkers is

   Init_H : Boolean := False;
   Last_H : Humidity;
   
   function Humidity_Checker return Boolean; -- True = Error
   function Tank_Empty return Boolean; -- True = Error

end Checkers;
