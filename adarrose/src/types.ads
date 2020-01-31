with Ada.Real_Time; use Ada.Real_Time;

package Types is

   type Humidity is new Float range 0.0 .. 100.0; -- Humidity percentage
   type Brightness is new Float range 0.0 .. 100.0; -- Brightness percentage
   type Volume is new Float range 0.0 .. Float'Last; -- Volume in milliliter (cl)
   type Length is new Float range 0.0 .. Float'Last; -- Length in centimeter (cm)
   type Debit is new Float range 0.0 .. Float'Last; -- Debit in milliliter per milliseconds (cl/ms)
   type Mode is (Continous, Economy, Scheduled, Punctual); -- Operating mode
   type Scheduler is record Start : Time; Stop : Time; end record; -- Time scheduler
   type Cylinder is record L : Length; D : Length; end record; -- Cylinder
   type Plant is record Container : Volume; Threshold : Humidity; end record;

   function "*" (Left, Right : Length) return Length;

end Types;
