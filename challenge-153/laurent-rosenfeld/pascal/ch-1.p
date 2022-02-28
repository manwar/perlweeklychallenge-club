Program leftfact;

var
    fact, left_fact: longint;
    i: integer;

begin
    left_fact := 1;
    fact := 1;
    for i := 1 to 10 do begin
        write(left_fact, ' ');
        fact := fact * i;
        left_fact := left_fact + fact;
    end;
    writeln('');
end.
