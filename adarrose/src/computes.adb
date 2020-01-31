with Ada.Numerics; use Ada.Numerics;
with Checkers; use Checkers;

package body Computes is

   -------------
   -- Compute --
   -------------

   function Compute (Pip : Cylinder; H : Humidity; P : Plant; Pum : Debit) return Time_Span
   is
      Water : constant Volume := Compute_Water(H, P);
   begin
      Tank_Update(Water);
      return Compute_Time(Pum, Water + Compute_Pipe(Pip));
   end Compute;

   ------------------
   -- Compute_Time --
   ------------------

   function Compute_Time (Pum : Debit; Water : Volume) return Time_Span
   is
   begin
      return Milliseconds(Integer(Float(Water) / Float(Pum)));
   end Compute_Time;

   -------------------
   -- Compute_Water --
   -------------------

   function Compute_Water (H : Humidity; P : Plant) return Volume
   is
   begin
      if P.Threshold <= H then
         return 0.0;
      else
         return Volume(Float(P.Container) * Float(P.Threshold - H));
      end if;
   end Compute_Water;

   ------------------
   -- Compute_Pipe --
   ------------------

   function Compute_Pipe (Pip : Cylinder) return Volume

   is
   begin
      return Volume(Pip.L * (Pip.D / 2.0) * (Pip.D / 2.0) *  Length(Pi) / 6.0);
   end Compute_Pipe;

end Computes;
