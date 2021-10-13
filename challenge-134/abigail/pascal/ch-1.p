Program XXX;

(*                  *)
(* See ../README.md *)
(*                  *)

(*                                                        *)
(* Run as: fpc -och-1.out ch-1.p; ./ch-1.out < input-file *)
(*                                                        *)

var
    tails: array [1 .. 5] of integer = (789, 798, 879, 897, 978);
    i: integer;

begin
    for i := 1 to 5 do begin
        writeln (1023456000 + tails [i]);
    end
end.
