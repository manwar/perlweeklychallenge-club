--  SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
--  SPDX-License-Identifier: BSD-2-Clause

with Ada.Text_IO;

with Third_Max;

procedure Ch_1 is
   Example_1 : Third_Max.Third_Max_Values := (5, 6, 4, 1);
   Example_2 : Third_Max.Third_Max_Values := (4, 5);
   Example_3 : Third_Max.Third_Max_Values := (1, 2, 2, 3);
begin
   Ada.Text_IO.Put_Line (Integer'Image (Third_Max.Third_Max (Example_1)));
   Ada.Text_IO.Put_Line (Integer'Image (Third_Max.Third_Max (Example_2)));
   Ada.Text_IO.Put_Line (Integer'Image (Third_Max.Third_Max (Example_3)));
end Ch_1;
