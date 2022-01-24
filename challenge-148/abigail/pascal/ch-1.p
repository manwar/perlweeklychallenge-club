Program XXX;

(*                                                                   *)
(* See https://theweeklychallenge.org/blog/perl-weekly-challenge-148 *)
(*                                                                   *)

(*                                           *)
(* Run as: fpc -och-1.out ch-1.p; ./ch-1.out *)
(*                                           *)

var
    i, t, u: integer;

begin
    for i := 1 to 100 do begin
        t := i div 10;
        u := i mod 10;
        if not ((i = 0) or (t = 1) or (u = 1) or (t = 7) or (u = 7)
                        or (t = 8) or (u = 8) or (t = 9) or (u = 9)
                        or (t = 2) or (u = 3) or (u = 5) or (i = 100))
                                                             then begin
            write (i, ' ');
        end;
    end;
    writeln ('');
end.
