Program ch1;

(*                                                                   *)
(* See https://theweeklychallenge.org/blog/perl-weekly-challenge-153 *)
(*                                                                   *)

(*                                           *)
(* Run as: fpc -och-1.out ch-1.p; ./ch-1.out *)
(*                                           *)

var
    sum, fac: longint;
    n: integer;

begin
    sum := 1;
    fac := 1;
    write (sum);
    for n := 1 to 9 do begin
        fac := fac * n;
        sum := sum + fac;
        write (' ', sum);
    end;
    writeln;
end.
