package body Errors is

   procedure Set_Message (I : Natural) is
   begin
      Index := I;
   end Set_Message;
   
   function Get_Message return String_Access is
   begin
      return Message(Index);
   end Get_Message;

end Errors;
