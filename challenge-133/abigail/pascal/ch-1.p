Program XXX;

(*                  *)
(* See ../README.md *)
(*                  *)

(*                                                        *)
(* Run as: fpc -och-1.out ch-1.p; ./ch-1.out < input-file *)
(*                                                        *)

uses math;

var n: integer;

begin
    while not eof do begin
        readln (n);
        writeln (Exp (lnxp1 (n - 1) / 2) : 1 : 0);
    end
end.
