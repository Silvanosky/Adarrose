package Types is
   
   type Humidity is new Natural range 0 .. 100; -- Humidity percentage
   type Brightness is new Natural range 0 .. 100; -- Brightness percentage
   type Volume is new Natural; -- Volume in milliliter (ml)
   type Status is (Decreasing, Idle, Increasing); -- Status over time
   type Debit is new Natural; -- Debit in milliliter per seconds (ml/s)

end Types;
