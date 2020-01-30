with Types; use Types;

package Plants is

   type Plant is record
      Container : Volume;
      Threshold : Humidity;
   end record;

end Plants;
