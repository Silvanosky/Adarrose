package body Errors is

   procedure Set_Message (I : Natural)
     with Pre => Index <= 3 and Index >= 1 
          Post => I = Index
   is
   begin
      Index := I;
   end Set_Message;
   
   function Get_Message return String_Access is
   begin
      return Message(Index);
   end Get_Message;

end Errors;
