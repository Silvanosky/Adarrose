with types; use types;

package plants is

   type plant is record
      Threshold : Humidity;
   end record;

   function compute_water (p : plant) return Water;

end plants;
