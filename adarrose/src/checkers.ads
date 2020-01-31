with Types; use Types;
with Errors; use Errors;
with Sensors; use Sensors;
with Configs; use Configs;

package Checkers is

   Init_H : Boolean := False;
   Last_H : Humidity;
   Tank_Current : Volume := 100.0;

   procedure Humidity_Checker_Before;

   function Humidity_Checker_After return Boolean -- True = Error
     with Pre => Last_H <= 100 and Last_H >= 0 and H <= 100 and H >= 0;

   procedure Tank_Update (V : Volume)
	   with Pre => Tank_Current <= Tank and V <= Tank and Tank_Current >= V,
          Post => Tank_Current'Old <= Tank_Current;

   function Tank_Empty return Boolean
     with Post => Tank_Empty'Result = (Tank_Current = Volume(0));

   procedure Light_Check (L : Brightness; Min : Brightness)
     with Pre => L <= 100 and L >= 0 and Min <= 100 and Min >= 0;

end Checkers;
