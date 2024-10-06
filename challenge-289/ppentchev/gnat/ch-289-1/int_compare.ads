--  SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
--  SPDX-License-Identifier: BSD-2-Clause

package Int_Compare is
   type IntRelation is (LessThan, EqualTo, GreaterThan);

   function Int_Comp (A, B : in Integer) return IntRelation;
end Int_Compare;
