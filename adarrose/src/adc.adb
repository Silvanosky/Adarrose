--  This program demonstrates reading the analog voltage value on a GPIO
--  pin with an ADC unit, using polling. The pin is continously polled in an
--  infinite loop, displaying the current sample on each iteration. Connect the
--  pin to an appropriate external input voltage to drive the displayed value.
--  Absent an input, the sensed (and displayed) value will be meaningless. The
--  green LED will toggle on each iteration, as an additional indication of
--  execution.
--
--  NB: The input voltage must not exceed the maximum allowed for the board's
--  circuitry!  A value between zero and three volts (inclusive) is safe.
--
--  The displayed value is the raw sample quantity in the range 0 .. 4095,
--  representing an input voltage of 0.0 to 3.0 volts. Thus, for an
--  incoming voltage of 1.5 volts, the sample would be approximately half of
--  4095, i.e., 2048.

--  Note that you will likely need to reset the board manually after loading.

--with Last_Chance_Handler;  pragma Unreferenced (Last_Chance_Handler);

with STM32.Board;  use STM32.Board;
with STM32.Device; use STM32.Device;

with HAL;          use HAL;
with STM32.ADC;    use STM32.ADC;
with STM32.GPIO;   use STM32.GPIO;

with LCD_Std_Out;

with Ada.Real_Time;  use Ada.Real_Time;

procedure ADC is

   Converter     : Analog_To_Digital_Converter renames ADC_1;
   Input_Channel : constant Analog_Input_Channel := 5;
   Input         : constant GPIO_Point := PA5;
   --  See the mapping of channels to GPIO pins at the top of the ADC package.
   --  Also see the board's User Manual for which GPIO pins are available.
   --  For example, on the F429 Discovery board, PA5 is not used by some
   --  other device, and maps to ADC channel 5.

   All_Regular_Conversions : constant Regular_Channel_Conversions :=
          (1 => (Channel => Input_Channel, Sample_Time => Sample_144_Cycles));

   Raw : UInt32 := 0;

   Successful : Boolean;

   procedure Print (X, Y : Natural; Value : String);

   procedure Configure_Analog_Input;

   -----------
   -- Print --
   -----------

   procedure Print (X, Y : Natural; Value : String) is
      Trailing_Blanks : constant String := "   ";  -- to clear the rest of line
   begin
      LCD_Std_Out.Put (X, Y, Value & " / 100" & Trailing_Blanks);
   end Print;

   ----------------------------
   -- Configure_Analog_Input --
   ----------------------------

   procedure Configure_Analog_Input is
   begin
      Enable_Clock (Input);
      Configure_IO (Input, (Mode => Mode_Analog, Resistors => Floating));
   end Configure_Analog_Input;

begin
   Initialize_LEDs;

   Configure_Analog_Input;

   Enable_Clock (Converter);

   Reset_All_ADC_Units;

   Configure_Common_Properties
     (Mode           => Independent,
      Prescalar      => PCLK2_Div_2,
      DMA_Mode       => Disabled,
      Sampling_Delay => Sampling_Delay_5_Cycles);

   Configure_Unit
     (Converter,
      Resolution => ADC_Resolution_12_Bits,
      Alignment  => Right_Aligned);

   Configure_Regular_Conversions
     (Converter,
      Continuous  => False,
      Trigger     => Software_Triggered,
      Enable_EOC  => True,
      Conversions => All_Regular_Conversions);

   Enable (Converter);

   loop
      Start_Conversion (Converter);

      Poll_For_Status (Converter, Regular_Channel_Conversion_Complete, Successful);
      if not Successful then
         Red_LED.Toggle;
      else
         Green_LED.Toggle;
         Raw := UInt32 (Conversion_Value (Converter)) * 100 / 4095;
         Print (0, 0, Raw'Img);
      end if;

      delay until Clock + Milliseconds (200); -- slow it down to ease reading
   end loop;
end ADC;
