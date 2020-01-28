with STM32.Board;           use STM32.Board;
with HAL.Bitmap;            use HAL.Bitmap;
with HAL.Touch_Panel;       use HAL.Touch_Panel;
with STM32.User_Button;     use STM32;
with BMP_Fonts;
with LCD_Std_Out;

procedure Main
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
      LCD_Std_Out.Put_Line ("Adarrose");

      Display.Update_Layer (1, Copy_Back => True);
   end Clear;

   Last_X : Integer := -1;
   Last_Y : Integer := -1;

   type Mode is (Drawing_Mode, Bitmap_Showcase_Mode);

   Current_Mode : Mode := Drawing_Mode;

begin

   --  Initialize LCD
   Display.Initialize;
   Display.Initialize_Layer (1, ARGB_8888);

   --  Initialize touch panel
   Touch_Panel.Initialize;

   --  Initialize button
   User_Button.Initialize;

   LCD_Std_Out.Set_Font (BMP_Fonts.Font8x8);
   LCD_Std_Out.Current_Background_Color := BG;

   --  Clear LCD (set background)
   Clear;

   --  The application: set pixel where the finger is (so that you
   --  cannot see what you are drawing).
   loop
      if User_Button.Has_Been_Pressed then
         case Current_Mode is
            when Drawing_Mode =>
               Current_Mode := Bitmap_Showcase_Mode;
            when Bitmap_Showcase_Mode =>
               Clear;
               Current_Mode := Drawing_Mode;
         end case;
      end if;

      if Current_Mode = Drawing_Mode then

         Display.Hidden_Buffer (1).Set_Source (HAL.Bitmap.Green);

         declare
            State : constant TP_State := Touch_Panel.Get_All_Touch_Points;
         begin
            if State'Length = 0 then
               Last_X := -1;
               Last_Y := -1;

            elsif State'Length = 1 then
               --  Lines can be drawn between two consecutive points only when
               --  one touch point is active: the order of the touch data is not
               --  necessarily preserved by the hardware.
               if Last_X > 0 then
                  Draw_Line
                    (Display.Hidden_Buffer (1).all,
                     Start     => (Last_X, Last_Y),
                     Stop      => (State (State'First).X, State (State'First).Y),
                     Thickness => State (State'First).Weight / 2,
                     Fast      => False);
               end if;

               Last_X := State (State'First).X;
               Last_Y := State (State'First).Y;

            else
               Last_X := -1;
               Last_Y := -1;
            end if;

            for Id in State'Range loop
               Fill_Circle
                 (Display.Hidden_Buffer (1).all,
                  Center => (State (Id).X, State (Id).Y),
                  Radius => State (Id).Weight / 4);
            end loop;

            if State'Length > 0 then
               Display.Update_Layer (1, Copy_Back => True);
            end if;
         end;
      else

         --  Show some of the supported drawing primitives

         Display.Hidden_Buffer (1).Set_Source (Black);
         Display.Hidden_Buffer (1).Fill;

         Display.Hidden_Buffer (1).Set_Source (Green);
         Display.Hidden_Buffer (1).Fill_Rounded_Rect
           (((10, 10), 100, 100), 20);

         Display.Hidden_Buffer (1).Set_Source (HAL.Bitmap.Red);
         Display.Hidden_Buffer (1).Draw_Rounded_Rect
           (((10, 10), 100, 100), 20, Thickness => 4);

         Display.Hidden_Buffer (1).Set_Source (HAL.Bitmap.Yellow);
         Display.Hidden_Buffer (1).Fill_Circle ((60, 60), 20);

         Display.Hidden_Buffer (1).Set_Source (HAL.Bitmap.Blue);
         Display.Hidden_Buffer (1).Draw_Circle ((60, 60), 20);

         Display.Hidden_Buffer (1).Set_Source (HAL.Bitmap.Violet);
         Display.Hidden_Buffer (1).Cubic_Bezier (P1        => (10, 10),
                                                 P2        => (60, 10),
                                                 P3        => (60, 60),
                                                 P4        => (100, 100),
                                                 N         => 200,
                                                 Thickness => 5);

         Copy_Rect (Src_Buffer  => Display.Hidden_Buffer (1).all,
                    Src_Pt      => (0, 0),
                    Dst_Buffer  => Display.Hidden_Buffer (1).all,
                    Dst_Pt      => (100, 100),
                    Width       => 100,
                    Height      => 100,
                    Synchronous => True);

         Display.Update_Layer (1, Copy_Back => False);
      end if;
   end loop;
end Main;

