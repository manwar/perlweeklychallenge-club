--  SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
--  SPDX-License-Identifier: BSD-2-Clause

with Ada.IO_Exceptions;
with Ada.Text_IO;
with Ada.Strings; use Ada.Strings;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with Jumble_Words;

procedure Ch_2 is
   Line : Ada.Strings.Unbounded.Unbounded_String;
begin
   loop
      Line := To_Unbounded_String (Ada.Text_IO.Get_Line);
      Ada.Text_IO.Put_Line (Jumble_Words.Jumble (To_String (Line)));
   end loop;
exception
   when Ada.IO_Exceptions.End_Error =>
      null;
end Ch_2;
