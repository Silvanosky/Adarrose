package Errors is

   type String_Access is access constant String;

   Message_1 : aliased constant String := "I am Groot.";
   Message_2 : aliased constant String := "No Humidity Increase.";
   Message_3 : aliased constant String := "Plants need water.";
   Message_4 : aliased constant String := "Please more light.";

   Message : Array (1 .. 4) of String_Access :=
     (
      1 => Message_1'Access,
      2 => Message_2'Access,
      3 => Message_3'Access,
      4 => Message_4'Access
     );
   Index : Natural := 1;

   procedure Set_Message (I : Natural);
   function Get_Message return String_Access;

end Errors;
