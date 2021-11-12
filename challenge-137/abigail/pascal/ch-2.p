Program XXX;

(*                  *)
(* See ../README.md *)
(*                  *)

(*                                                        *)
(* Run as: fpc -och-2.out ch-2.p; ./ch-2.out < input-file *)
(*                                                        *)

var
    n: Longint;

function reverse (num: Longint): Longint;
    var
        rev: Longint;

    begin
        rev := 0;
        while num > 0 do begin
            rev := rev * 10;
            rev := rev + (num mod 10);
            num := num div 10;
        end;
        reverse := rev;
    end;


function ly (num: Longint): integer;
    begin
        if num >= 10000000 then
            ly := 1
        else if num = reverse (num) then
            ly := 0
        else 
            ly := ly (num + reverse (num))
    end;
      

begin
    while not eof do begin
        readln (n);
        writeln (ly (n));
    end
end.
