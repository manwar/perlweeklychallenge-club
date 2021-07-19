Program XXX;

(*                  *)
(* See ../README.md *)
(*                  *)

(*                                                        *)
(* Run as: fpc -och-1.out ch-1.p; ./ch-1.out < input-file *)
(*                                                        *)

var
    n: integer;
    s: integer = 0;
    c: integer = 0;


begin
    while not eof () do begin
        readln (n);
        s := s + n;
        c := c + 1;
        writeln (s div c);
    end
end.
