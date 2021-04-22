program chowla;
const
    max = 37;

var
    j, res : integer;

function chowla(n: integer): integer;
var
    i, sum, rounded_half: integer;
begin
    sum := 0;
    rounded_half := round(n/2);
    for i := 2 to rounded_half do
    begin
        if (n mod i = 0) then
            sum := sum + i
    end;
    chowla := sum;
end;

begin
    for j := 1 to max do
    begin
        write(chowla(j), ' ');
    end;
    writeln(' ');
end.
