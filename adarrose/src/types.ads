with Ada.Real_Time; use Ada.Real_Time;

package Types is
   
   type Humidity is new Natural range 0 .. 100; -- Humidity percentage
   type Brightness is new Natural range 0 .. 100; -- Brightness percentage
   type Volume is new Natural; -- Volume in milliliter (cl)
   type Length is new Natural; -- Length in centimeter (cm)
   type Status is (Decreasing, Idle, Increasing); -- Status over time
   type Debit is new Natural; -- Debit in milliliter per milliseconds (cl/ms)
   type Mode is (Continous, Economy, Scheduled, Spot); -- Operating mode
   type Scheduler is record Start : Time; Stop : Time; end record; -- Time scheduler
   type Cylinder is record L : Length; D : Length; end record; -- Cylinder

   function "*" (Left, Right : Length) return Length;
   
end Types;
