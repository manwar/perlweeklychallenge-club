Program XXX;

(*                                                                   *)
(* See https://theweeklychallenge.org/blog/perl-weekly-challenge-002 *)
(*                                                                   *)

(*                                                        *)
(* Run as: fpc -och-1.out ch-1.p; ./ch-1.out < input-file *)
(*                                                        *)

var
    i: LongInt;

begin
    while not eof do begin
        readln (i);
        writeln (i);
    end
end.
