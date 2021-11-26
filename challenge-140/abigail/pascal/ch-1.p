Program ch1;

uses Strutils;

(*                  *)
(* See ../README.md *)
(*                  *)

(*                                                        *)
(* Run as: fpc -och-1.out ch-1.p; ./ch-1.out < input-file *)
(*                                                        *)

function bin2dec (bin: string): longint;
    var
        c: char;
        dec: integer = 0;

    begin
        for c in bin do begin
            dec := dec * 2;
            if c = '1' then begin
                dec := dec + 1;
            end;
        end;
        bin2dec := dec;
    end;

var 
    n1, n2: longint;
    a, b: string;

begin
    while not eof do begin
        readln (n1, n2);
        a := Dec2Numb (n1, 1, 10);
        b := Dec2Numb (n2, 1, 10);

        writeln (Dec2Numb (bin2dec (a) + bin2dec (b), 1, 2));
    end
end.
