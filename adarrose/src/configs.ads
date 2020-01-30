with Ada.Real_Time; use Ada.Real_Time;
with Plants; use Plants;
with Types; use Types;

package Configs is

   Tank : constant Volume := 100;
   Plant_Pot : constant Plant := (Container => 10, Threshold => 50);
   Pump : constant Debit := 1;
   Operating_Mode : Mode := Continous;
   Bastle : Boolean := True;
   Schedule : Scheduler;-- := (Start => 12, Stop => 16);
   Day_Time : Scheduler;-- := (Start => 8, Stop => 20);

end Configs;
