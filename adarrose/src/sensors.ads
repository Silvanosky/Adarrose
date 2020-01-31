with Types; use Types;

package Sensors is

   H : Humidity := 0;
   L : Brightness := 0;


   procedure Init;

	procedure Update
	   with Post => H /= 0 and L /= 0;

end Sensors;
