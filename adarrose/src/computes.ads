with Ada.Real_Time; use Ada.Real_Time;
with Types; use Types;

package Computes is

   function Compute (Pip : Cylinder; H : Humidity; P : Plant; Pum : Debit) return Time_Span;
   function Compute_Time (Pum : Debit; Water : Volume) return Time_Span;
   function Compute_Water (H : Humidity; P : Plant) return Volume;
   function Compute_Pipe (Pip : Cylinder) return Volume;

end Computes;
