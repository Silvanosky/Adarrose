with Ada.Real_Time; use Ada.Real_Time;
with Types; use Types;

package Configs is

   --Refresh_Time : constant Time_Span := Seconds(3600);
   Refresh_Time : constant Time_Span := Seconds(1);
   Tank : constant Volume := 100;
   Plant_Pot : constant Plant := (Container => 10, Threshold => 50);
   Plant_Consumption : constant Humidity := 5; -- Humidity per hour;
   Pump : constant Debit := 1;
   Operating_Mode : Mode := Continous;
   Bastle : Boolean := True;
   Schedule : Scheduler;-- := (Start => 12, Stop => 16);
   Pipe : Cylinder := (L => Length(10), D => Length(1));
   Light : constant Brightness := 10;
   Light_Time_Min : constant Time_Span := Seconds(4 * 3600);
   -- Time_Global : constant Time := Time_Of(2020, 01, 31);

end Configs;
