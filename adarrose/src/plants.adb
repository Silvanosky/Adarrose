package body Plants is

   -------------------
   -- Compute_Water --
   -------------------

   function Compute_Water (Self : Plant; h : Humidity) return Volume is
   begin
      if Self.Threshold <= h then
         return 0;
      else
         return Volume(Natural'Val(Self.Container) * Natural'Val(Self.Threshold - h) / 2);
      end if;
   end Compute_Water;

end Plants;
