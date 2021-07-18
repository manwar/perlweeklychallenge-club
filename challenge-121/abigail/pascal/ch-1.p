Program XXX;

(*                  *)
(* See ../README.md *)
(*                  *)

(*                                                        *)
(* Run as: fpc -och-1.out ch-1.p; ./ch-1.out < input-file *)
(*                                                        *)

var m, n: integer;

begin
    while not eof () do begin
        readln (m, n);
        writeln (m xor (1 shl (n - 1)));
    end
end.
