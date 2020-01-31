with STM32.Board;           use STM32.Board;
with HAL.Bitmap;            use HAL.Bitmap;
with HAL.Touch_Panel;       use HAL.Touch_Panel;
with HAL.Framebuffer;		use HAL.Framebuffer;
with STM32.User_Button;     use STM32;
with BMP_Fonts;
with LCD_Std_Out;

with Types; use Types;
with Sensors; use Sensors;
with Logger;
with Errors;

with Ada.Real_Time; use Ada.Real_Time;

package body Screen
is
	BG : constant Bitmap_Color := (Alpha => 255, others => 64);

	procedure Clear;

	-----------
	-- Clear --
	-----------

	procedure Clear is
	begin
		Display.Hidden_Buffer (1).Set_Source (BG);
		Display.Hidden_Buffer (1).Fill;

		LCD_Std_Out.Clear_Screen;
		LCD_Std_Out.Set_Orientation(Landscape);
		LCD_Std_Out.Put (130, 0, "ADArrose");

		Display.Update_Layer (1, Copy_Back => True);
	end Clear;

	type Display_Mode is (Board_Mode, Graph_Mode);

	Current_Mode : Display_Mode := Board_Mode;

	procedure Init is
	begin
		--  Initialize LCD
		Display.Initialize;
		Display.Initialize_Layer (1, ARGB_8888);

		--  Initialize touch panel
		Touch_Panel.Initialize;

		--  Initialize button
		User_Button.Initialize;

		LCD_Std_Out.Set_Font (BMP_Fonts.Font16x24);
		LCD_Std_Out.Current_Background_Color := BG;

		--  Clear LCD (set background)
		Clear;
	end Init;

	procedure Print is
		T : Integer := 0;
	    Err : String := Errors.Get_Message.ALL;
	begin

		declare
			State : constant TP_State := Touch_Panel.Get_All_Touch_Points;
		begin

			if User_Button.Has_Been_Pressed or State'Length = 1 then
				case Current_Mode is
					when Board_Mode =>
						Clear;
						Current_Mode := Graph_Mode;
					when Graph_Mode =>
						Clear;
						Current_Mode := Board_Mode;
				end case;
			end if;

		end;
		if Current_Mode = Board_Mode then
			LCD_Std_Out.Set_Font (BMP_Fonts.Font16x24);
			LCD_Std_Out.Put (0, 30, "Humidity: "& Sensors.H'Img & " %     ");
			LCD_Std_Out.Put (0, 60, "Light: " & Sensors.L'Img & " %     ");
			T := Logger.Light_Time / Seconds(60);
			LCD_Std_Out.Put (0, 90, "Light Time: " & T'Img & " Min     ");
			LCD_Std_Out.Set_Font (BMP_Fonts.Font8x8);
			LCD_Std_Out.Put (0, 130, "Status: " & Err & "      ");

			--Display.Update_Layer (1, Copy_Back => False);
		else
			Display.Hidden_Buffer (1).Set_Source (BG);
			Display.Hidden_Buffer (1).Fill_Rect
				(((0, 140), 320, 240));

			Display.Hidden_Buffer (1).Set_Source (HAL.Bitmap.Blue);
			for Id in Logger.H_Vector.First_Index .. Logger.H_Vector.Last_Index-1 loop
				Draw_Line
                    (Display.Hidden_Buffer (1).all,
                     Start     => (Id * 320 / Logger.Max_Values, 240 - Integer(Logger.H_Vector.Element(Id))),
                     Stop      => ((Id+1) * 320 / Logger.Max_Values, 240 - Integer(Logger.H_Vector.Element(Id+1))),
                     Thickness => 1,
                     Fast      => False);

			end loop;

			Display.Hidden_Buffer (1).Set_Source (HAL.Bitmap.Yellow);
			for Id in Logger.L_Vector.First_Index .. Logger.L_Vector.Last_Index-1 loop
				Draw_Line
                    (Display.Hidden_Buffer (1).all,
                     Start     => (Id * 320 / Logger.Max_Values, 240 - Integer(Logger.L_Vector.Element(Id))),
                     Stop      => ((Id+1) * 320 / Logger.Max_Values, 240 - Integer(Logger.L_Vector.Element(Id+1))),
                     Thickness => 1,
                     Fast      => False);

			end loop;

			Display.Update_Layer (1, Copy_Back => True);
		end if;

	end Print;

end Screen;

