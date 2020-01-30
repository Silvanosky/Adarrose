with Ada.Real_Time; use Ada.Real_Time;
with Configs; use Configs;
with Plants; use Plants;
with Types; use Types;

package Decisions is

   function Make_Decision (H : Humidity) return Time_Span;
   function Compute_Time(Water : Volume) return Time_Span;
   function Compute_Water (P : Plant; h : Humidity) return Volume;

end Decisions;
