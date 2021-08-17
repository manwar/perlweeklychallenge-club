program venus;
var
    lines: array[0..4] of string = ('   OOOOO', '  O     O', ' O       O', 'O         O', '     O');
    indexes: array[0..16] of integer = (0, 1, 2, 3, 3, 3, 3, 3, 2, 1, 0, 4, 4, 4, 0, 4, 4);
    i: integer;
begin
    for i:= 0 to 16 do
    writeln(lines[indexes[i]]);
end.
