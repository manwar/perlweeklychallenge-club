--  SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
--  SPDX-License-Identifier: BSD-2-Clause

with Int_Compare; use Int_Compare;

package Third_Max is
   type Third_Max_Index is range 1 .. 3;
   type Third_Max_Array is array (Third_Max_Index) of Integer;

   procedure Third_Max_Update
      (Count : in out Third_Max_Index;
       Values : in out Third_Max_Array;
       New_Value : in Integer);

   type Third_Max_Values is array (Integer range <>) of Integer;

   function Third_Max (Values : Third_Max_Values) return Integer;
end Third_Max;
