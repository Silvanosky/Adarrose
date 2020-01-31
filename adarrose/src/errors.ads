with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package Errors is

   type String_Access is access constant String;

   Message_1 : aliased constant String := "Pump was active but humidity decreased.";
   Message_2 : aliased constant String := "Tank is empty.";
   Message_3 : aliased constant String := "Plant needs better exposure.";

   Message : Array (1 .. 3) of String_Access :=
     (
      1 => Message_1'Access,
      2 => Message_2'Access,
      3 => Message_3'Access
     );
   Index : Natural := 1;

   procedure Set_Message (I : Natural);
   function Get_Message return String_Access;

end Errors;
