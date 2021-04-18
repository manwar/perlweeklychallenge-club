program bell;
const
    max = 9;

var
    tr: array [0..max, 0..max] of integer;
    row, i : integer;

begin
    tr[0, 0] := 1;
    for row := 1 to max do
        begin
            tr[row, 0] := tr[row - 1, row -1];
            for i := 1 to row do
                tr[row, i] := tr[row, i-1] + tr[row - 1, i-1];
        end;
    write('The first Bell numbers are: ');
    for row :=0 to max do
        write(tr[row, 0], ' ');
    writeln;
end.
