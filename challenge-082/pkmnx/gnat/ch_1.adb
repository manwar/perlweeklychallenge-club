
with ada.command_line; use ada.command_line;
with ada.Text_IO; use ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure ch_1 is
   M : Long_Integer := Long_Integer'Value(argument (1));
   N : Long_Integer := Long_Integer'Value(argument (2));
   p : Long_Integer := 0;
   gcd : Long_Integer := 0;
   i : Long_Integer := 0;
begin

   gcd := N;

   while (M /= 0) loop
      p := gcd;
      gcd := M;
      M := p mod M;
   end loop;

   for i in 1 .. gcd loop
      if ( ( gcd mod i ) = 0 ) then
         put( Long_Integer'Image(i) );
      end if;
   end loop;

end ch_1;
