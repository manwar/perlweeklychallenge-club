program dot_product;
const
    SIZE = 2;
var
    a1: array[0..SIZE] of integer = (1, 2, 3);
    a2: array[0..SIZE] of integer = (4, 5, 6);
    result, i : integer;
begin
    result := 0;
    for i := 0 to SIZE do
        result += a1[i] * a2[i];
    writeln(result);
end.
