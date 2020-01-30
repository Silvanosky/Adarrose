with Types; use Types;
with Plants; use Plants;

package Configs is

   Tank : constant Volume := 1000;
   Plant_Pot : constant Plant := (Threshold => 50, Container => 100);
   Pump : constant Debit := 10;

end Configs;
