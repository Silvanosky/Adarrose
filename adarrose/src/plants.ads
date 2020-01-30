with Types; use Types;

package Plants is

   type Plant is record
      Threshold : Humidity;
      Container : Volume;
   end record;

   function Compute_Water (Self : Plant; h : Humidity) return Volume;

end Plants;
