program memAddress;
var
   value: integer;
   intPtr: ^integer;
   result: ^word;

begin
   value := 42;
   intPtr := @value;
   result := addr(intPtr);
   writeln('Memory address of value is: ', result^);
end.
