Program XXX;

(*                                                                   *)
(* See https://theweeklychallenge.org/blog/perl-weekly-challenge-001 *)
(*                                                                   *)

(*                                                        *)
(* Run as: fpc -och-2.out ch-2.p; ./ch-2.out < input-file *)
(*                                                        *)

var
    i, max: integer;

begin
    while not eof do begin
        readln (max);
        for i := 1 to max do begin
            if i mod 15 = 0 then begin
                writeln ('fizzbuzz');
                continue;
            end;
            if i mod  5 = 0 then begin
                writeln (    'buzz');
                continue;
            end;
            if i mod  3 = 0 then begin
                writeln ('fizz'    );
                continue;
            end;
            writeln (i);
        end
    end
end.
