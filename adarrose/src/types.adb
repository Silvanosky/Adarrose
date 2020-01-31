package body Types is

   ---------
   -- "*" --
   ---------

   function "*" (Left, Right : Length) return Length is
   begin
      return Length(Natural(Left) * Natural(Right));
   end "*";

end Types;
