Program ch2;

(*                                                                   *)
(* See https://theweeklychallenge.org/blog/perl-weekly-challenge-153 *)
(*                                                                   *)

(*                                                        *)
(* Run as: fpc -och-2.out ch-2.p; ./ch-2.out < input-file *)
(*                                                        *)

var
    fac: array [0 .. 9] of longint;
    n: integer;
    num, sum: longint;

begin
    fac [0] := 1;
    for n := 1 to 9 do begin
        fac [n] := n * fac [n - 1];
    end;

    while not eof do begin
        readln (num);
        n := num;
        while n > 0 do begin
            sum := sum + fac [n mod 10];
            n   := n div 10;
        end;
        if num = sum then begin
            writeln (1);
        end
        else begin
            writeln (0);
        end;
    end
end.
