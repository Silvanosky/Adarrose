with Types; use Types;
with Ada.Containers.Vectors;

with Ada.Real_Time; use Ada.Real_Time;

package Logger is

	package Humidity_Vectors is new Ada.Containers.Vectors
		(Index_Type   => Natural,
		 Element_Type => Humidity);

	package Light_Vectors is new Ada.Containers.Vectors
		(Index_Type   => Natural,
		 Element_Type => Brightness);

	H_Vector : Humidity_Vectors.Vector;
	L_Vector : Light_Vectors.Vector;

	Light_Time : Time_Span := Seconds(0);

	procedure Update;

end Logger;
