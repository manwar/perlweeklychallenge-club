--  SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
--  SPDX-License-Identifier: BSD-2-Clause

package body Third_Max is
   procedure Third_Max_Update
      (Count : in out Third_Max_Index;
       Values : in out Third_Max_Array;
       New_Value : in Integer)
      is
   begin
      case Int_Comp (New_Value, Values (1)) is
         when LessThan =>
            if Count = 1 then
               Values (2) := New_Value;
               Count := 2;
            else
               case Int_Comp (New_Value, Values (2)) is
                  when LessThan =>
                     if Count = 2 then
                        Values (3) := New_Value;
                        Count := 3;
                     elsif Values (3) < New_Value then
                        Values (3) := New_Value;
                     end if;

                  when EqualTo =>
                     null;

                  when GreaterThan =>
                     if Count = 2 then
                        Count := 3;
                     end if;

                     Values (3) := Values (2);
                     Values (2) := New_Value;
               end case;
            end if;

         when EqualTo =>
            null;

         when GreaterThan =>
            case Count is
               when 3 =>
                  Values (3) := Values (2);
               when 2 =>
                  Values (3) := Values (2);
                  Count := 3;
               when 1 =>
                  Count := 2;
            end case;

            Values (2) := Values (1);
            Values (1) := New_Value;
      end case;
   end Third_Max_Update;

   function Third_Max (Values : Third_Max_Values) return Integer is
      Count      : Third_Max_Index;
      Acc_Values : Third_Max_Array;
      Value_Idx  : Integer;
   begin
      for Value_Idx in Values'Range loop
         if Value_Idx = Values'First then
            Count := 1;
            Acc_Values (1) := Values (Value_Idx);
         else
            Third_Max_Update (Count, Acc_Values, Values (Value_Idx));
         end if;
      end loop;

      if Count = 3 then
         return Acc_Values (3);
      else
         return Acc_Values (1);
      end if;
   end Third_Max;
end Third_Max;
