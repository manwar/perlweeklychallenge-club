--  SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
--  SPDX-License-Identifier: BSD-2-Clause

with Ada.Numerics.Discrete_Random;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with GNAT.Regpat; use GNAT.Regpat;

package body Jumble_Words is
   Word_Pattern : constant Pattern_Matcher := Compile (
      "[A-Za-z]([A-Za-z]{2,})[A-Za-z]");

   procedure Jumble_Chars (Word : in out String) is
   begin
      for Idx in Word'First .. Natural'Pred (Word'Last) loop
         declare
            subtype Remaining is Natural range Idx .. Word'Last;
            package RandIdx is new Ada.Numerics.Discrete_Random (Remaining);
            use RandIdx;
            Seed : Generator;
            Swap_Idx : Remaining;
         begin
            Reset (Seed);
            Swap_Idx := Random (Seed);
            if Swap_Idx /= Idx then
               declare
                  Temp : constant Character := Word (Idx);
               begin
                  Word (Idx) := Word (Swap_Idx);
                  Word (Swap_Idx) := Temp;
               end;
            end if;
         end;
      end loop;
   end Jumble_Chars;

   function Jumble (Text : String) return String is
      Length : constant Natural := Text'Length;
      Matches : Match_Array (0 .. 1);
      Offset : Natural;
      Result : Unbounded_String;
   begin
      Offset := Text'First;
      loop
         Match (Word_Pattern, Text (Offset .. Length), Matches);
         if Matches (0) = No_Match then
            Append (Result, Text (Offset .. Length));
            return To_String (Result);
         else
            declare
               First : constant Natural := Matches (1).First;
               Last : constant Natural := Matches (1).Last;
               Word : String (1 .. Last - First + 1) := Text (First .. Last);
            begin
               Jumble_Chars (Word);
               Append (
                  Result,
                  Text (Offset .. First - 1) &
                     Word &
                     Text (Last + 1 .. Last + 1));

               if Last < Length then
                  Offset := Last + 2;
               else
                  return To_String (Result);
               end if;
            end;
         end if;
      end loop;
   end Jumble;
end Jumble_Words;
