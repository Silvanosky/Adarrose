with STM32.Board;   use STM32.Board;

with STM32.GPIO;    use STM32.GPIO;
with Ada.Real_Time; use Ada.Real_Time;

procedure Sensors is

   Period : constant Time_Span := Milliseconds (200);  -- arbitrary

   Next_Release : Time := Clock;

   light : GPIO_Point := Pin_1;

begin
   STM32.Board.Initialize_LEDs;

   loop
      Toggle (All_LEDs);

      Next_Release := Next_Release + Period;
      delay until Next_Release;
   end loop;
end Blinky;
