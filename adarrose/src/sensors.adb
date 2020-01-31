with STM32.Device; use STM32.Device;
with STM32.Board;  use STM32.Board;
with HAL.Bitmap;   use HAL.Bitmap;

with HAL;          use HAL;
with STM32.ADC;    use STM32.ADC;
with STM32.GPIO;   use STM32.GPIO;

with LCD_Std_Out;

with Ada.Real_Time;  use Ada.Real_Time;

package body Sensors is

   ADC1     : Analog_To_Digital_Converter renames ADC_1;
   ADC2     : Analog_To_Digital_Converter renames ADC_2;

   Successful : Boolean;

   procedure Print (X, Y : Natural; Value : String) is
      Trailing_Blanks : constant String := "   ";  -- to clear the rest of line
   begin
      LCD_Std_Out.Put (X, Y, Value & " / 100" & Trailing_Blanks);
   end Print;

   Pin_Humidity : constant GPIO_Point := PA5;
   Channel_Humidity : constant Analog_Input_Channel := 5;

   Pin_Light : constant GPIO_Point := PA6;
   Channel_Light : constant Analog_Input_Channel := 6;

   procedure Init is
	   All_Regular_Conversions : constant Regular_Channel_Conversions :=
		   (1 => (Channel => Channel_Humidity, Sample_Time => Sample_144_Cycles));

	   All_Regular_Conversions2 : constant Regular_Channel_Conversions :=
		   (1 => (Channel => Channel_Light, Sample_Time => Sample_144_Cycles));

   begin
	   Enable_Clock (Pin_Humidity);
	   Configure_IO (Pin_Humidity, (Mode => Mode_Analog, Resistors => Floating));

	   Enable_Clock (Pin_Light);
	   Configure_IO (Pin_Light, (Mode => Mode_Analog, Resistors => Floating));

	   Enable_Clock (ADC1);
	   Enable_Clock (ADC2);

	   Reset_All_ADC_Units;

	   Configure_Common_Properties
		   (Mode          => Independent,
		   Prescalar      => PCLK2_Div_2,
		   DMA_Mode       => Disabled,
		   Sampling_Delay => Sampling_Delay_5_Cycles);

	   Configure_Unit
		   (ADC1,
		   Resolution => ADC_Resolution_12_Bits,
		   Alignment  => Right_Aligned);
	   Configure_Unit
		   (ADC2,
		   Resolution => ADC_Resolution_12_Bits,
		   Alignment  => Right_Aligned);

	   Configure_Regular_Conversions
		   (ADC1,
		   Continuous  => False,
		   Trigger     => Software_Triggered,
		   Enable_EOC  => True,
		   Conversions => All_Regular_Conversions);

	   Configure_Regular_Conversions
		   (ADC2,
		   Continuous  => False,
		   Trigger     => Software_Triggered,
		   Enable_EOC  => True,
		   Conversions => All_Regular_Conversions2);

	   Enable (ADC1);
	   Enable (ADC2);

   end Init;

   function Positive (A : UInt32) return Uint32 is
   begin
       if A > 0 then
	       return A;
	   else
	       return 0;
	   end if;
   end Positive;

   procedure Update
   is
   begin
       --Get Humidity sensor
	   Start_Conversion (ADC1);
	   Poll_For_Status (ADC1, Regular_Channel_Conversion_Complete, Successful);
	   H := Humidity(100 - Positive(UInt32(Conversion_Value (ADC1)) - 2048) * 100 / 2048); -- update humidity
--	   Print (0, 0, h'Img);

	   --Get light
	   Start_Conversion (ADC2);
	   Poll_For_Status (ADC2, Regular_Channel_Conversion_Complete, Successful);
	   L := Brightness(Positive(UInt32(Conversion_Value (ADC2)) * 100 / 4095)); -- update light
--	   Print (0, 50, l'Img);

   end Update;

end Sensors;
