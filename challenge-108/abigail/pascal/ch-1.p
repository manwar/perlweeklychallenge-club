Program XXX;

(*                  *)
(* See ../README.md *)
(*                  *)

(*                                           *)
(* Run as: fpc -och-1.out ch-1.p; ./ch-1.out *)
(*                                           *)

var i: Integer;
    p: ^Integer;
    w: ^Word;

begin
    p := @i;
    w := addr (p);
    writeln (w^);
end.
