with HAL;          use HAL;
with STM32.User_Button;
with STM32.Device;  use STM32.Device;
with STM32.GPIO;    use STM32.GPIO;
with Ada.Real_Time; use Ada.Real_Time;
with System;        use System;

package body Pump is

	Pin_Pump  : GPIO_Point renames PD13;

	procedure Init is
	begin
		Enable_Clock (Pin_Pump);

		Configure_IO
			(Pin_Pump,
			(Mode        => Mode_Out,
			Output_Type => Push_Pull,
			Speed       => Speed_100MHz,
			Resistors   => Floating));
		Set(Pin_Pump);

	end Init;

	procedure Run (Time : Time_Span) is
	begin
		Pin_Pump.Clear;
		delay until Clock + Time;
		Pin_Pump.Set;
	end Run;

end Pump;
