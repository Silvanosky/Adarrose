package types is
   
   type Humidity is new Natural range 0 .. 100;
   type Water is new Natural;
   type Status is (Decreasing, Idle, Increasing);

end types;
