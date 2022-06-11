Program XXX;

(*                                                                   *)
(* See https://theweeklychallenge.org/blog/perl-weekly-challenge-150 *)
(*                                                                   *)

(*                                           *)
(* Run as: fpc -och-2.out ch-2.p; ./ch-2.out *)
(*                                           *)

var
    primes: array [1 .. 8] of integer = (2, 3, 5, 7, 11, 13, 17, 19);
    n, p: integer;
    has_square: boolean;

begin
    for n := 1 to 500 do begin
        has_square := false;
        for p := 1 to 8 do begin
            if (n mod (primes [p] * primes [p])) = 0 then begin
                has_square := true;
            end;
        end;
        if not has_square then begin
            write (n, ' ');
        end
    end;
    writeln ('');
end.
