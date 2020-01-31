with Ada.Real_Time; use Ada.Real_Time;
with Types; use Types;

package Computes is

   function Compute (Pip : Cylinder; H : Humidity; P : Plant; Pum : Debit) return Time_Span
     with Post => Compute'Result >= Seconds(0);

   function Compute_Time (Pum : Debit; Water : Volume) return Time_Span
     with Post => Compute_Time'Result >= Seconds(0);

   function Compute_Water (H : Humidity; P : Plant) return Volume
     with Pre => H <= 100 and H >= 0;

   function Compute_Pipe (Pip : Cylinder) return Volume
     with
		Pre => Float(Pip.L) <= Float'Last and Float(Pip.L) >= 0.0 and Float(Pip.D) <= Float'Last and Float(Pip.D) >= 0.0,
          Post => Compute_Pipe'Result >= 0.0;

end Computes;
