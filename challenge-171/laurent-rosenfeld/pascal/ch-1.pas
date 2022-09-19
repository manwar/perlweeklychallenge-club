program abundant;
const
    max = 20;
var
    count, j: integer;

function is_abundant(n: integer): boolean;
var
    sum, i: integer;
begin
    sum := 0;
    for  i := 2 to round(n/2) do
    begin
        if ( n mod i = 0) then
            sum := sum + i;
            if (sum > n) then
                exit(true);
    end;
    exit(false);
end;

begin
    count := 0;
    j := 1;
    while ( count < max ) do
    begin
        if (is_abundant(j)) then
        begin
             write(j, ' ');
             count := count + 1;
        end;
        j := j + 2;
    end;
end.
