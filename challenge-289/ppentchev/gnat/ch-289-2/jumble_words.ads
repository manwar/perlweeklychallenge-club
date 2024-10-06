--  SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
--  SPDX-License-Identifier: BSD-2-Clause

package Jumble_Words is
   function Jumble (Text : String) return String;
private
   procedure Jumble_Chars (Word : in out String);
end Jumble_Words;
