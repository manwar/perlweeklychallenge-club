(*
    To compile and run:
    $ fpc ch-1.pas
    $ ./ch-1 100
    13015
*)

program Hello(input, output);

uses sysutils;

var
    n, x, y, s: integer;

function gcd(a, b: integer): integer;
var
    t: integer;
begin
    while b <> 0 do begin
        t := b;
        b := a mod b;
        a := t;
    end;

    gcd := a
end;

begin
    if paramCount() = 0 then
        n := 3
    else
        n := StrToInt(paramStr(1));
    
    s := 0;
    for x := 1 to n do
        for y := x + 1 to n do
            s += gcd(x, y);

    writeln(s);
end.
