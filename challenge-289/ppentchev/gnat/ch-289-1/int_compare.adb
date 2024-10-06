--  SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
--  SPDX-License-Identifier: BSD-2-Clause

package body Int_Compare is
   function Int_Comp (A, B : in Integer)
      return IntRelation
      is
   begin
      if A > B then
         return GreaterThan;
      elsif A < B then
         return LessThan;
      else
         return EqualTo;
      end if;
   end Int_Comp;
end Int_Compare;
