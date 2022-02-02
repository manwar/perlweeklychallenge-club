Program XXX;

(*                                                                   *)
(* See https://theweeklychallenge.org/blog/perl-weekly-challenge-150 *)
(*                                                                   *)

(*                                                        *)
(* Run as: fpc -och-1.out ch-1.p; ./ch-1.out < input-file *)
(*                                                        *)

uses
    StrUtils, types;

var
    line: string;
    fibs: TStringDynArray;
    fib_tmp, fib_prev, fib_last: string;

begin
    while not eof do begin
        readln (line);
        fibs     := SplitString (line, ' ');
        fib_prev := fibs [0];
        fib_last := fibs [1];
        while length (fib_last) < 51 do begin
            fib_tmp  := fib_last;
            fib_last := concat (fib_prev, fib_last);
            fib_prev := fib_tmp;
        end;
        writeln (fib_last [51]);
    end
end.
