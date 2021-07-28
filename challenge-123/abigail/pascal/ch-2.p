Program IsSquare;

(*                  *)
(* See ../README.md *)
(*                  *)

(*                                                        *)
(* Run as: fpc -och-2.out ch-2.p; ./ch-2.out < input-file *)
(*                                                        *)

var
    x1, y1, x2, y2, x3, y3, x4, y4: integer;
    e1, e2, e3, e4, d1, d2: integer;

begin
    while not eof () do begin
        readln (x1, y1, x2, y2, x3, y3, x4, y4);
        e1 := (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2);
        e2 := (x2 - x3) * (x2 - x3) + (y2 - y3) * (y2 - y3);
        e3 := (x3 - x4) * (x3 - x4) + (y3 - y4) * (y3 - y4);
        e4 := (x4 - x1) * (x4 - x1) + (y4 - y1) * (y4 - y1);
        d1 := (x1 - x3) * (x1 - x3) + (y1 - y3) * (y1 - y3);
        d2 := (x2 - x4) * (x2 - x4) + (y2 - y4) * (y2 - y4);
        if (e1 = e2) and (e2 = e3) and (e3 = e4) and (d1 = d2) then begin
            writeln (1);
        end
        else begin
            writeln (0);
        end
    end
end.
