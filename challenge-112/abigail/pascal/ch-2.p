Program StairCase;

(*                  *)
(* See ../README.md *)
(*                  *)

(*                                                        *)
(* Run as: fpc -och-2.out ch-2.p; ./ch-2.out < input-file *)
(*                                                        *)

uses math;

const
    sqrt5 = sqrt (5);
    phi   = (1 + sqrt5) / 2;

var
    n: integer;

begin
    while not eof () do
    begin
        readln  (n);
        writeln (round (power (phi, n + 1) / sqrt5));
    end
end.
