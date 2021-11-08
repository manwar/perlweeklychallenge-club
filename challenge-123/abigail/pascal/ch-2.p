Program IsSquare;

(*                  *)
(* See ../README.md *)
(*                  *)

(*                                                        *)
(* Run as: fpc -och-2.out ch-2.p; ./ch-2.out < input-file *)
(*                                                        *)

function dist (x1, y1, x2, y2: integer): integer;
begin
    dist := (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)
end;

var
    x1, y1, x2, y2, x3, y3, x4, y4: integer;

begin
    while not eof () do begin
        readln (x1, y1, x2, y2, x3, y3, x4, y4);
        if (dist (x1, y1, x2, y2) = dist (x2, y2, x3, y3)) and
           (dist (x2, y2, x3, y3) = dist (x3, y3, x4, y4)) and
           (dist (x3, y3, x4, y4) = dist (x4, y4, x1, y1)) and
           (dist (x1, y1, x3, y3) = dist (x2, y2, x4, y4)) then begin
            writeln (1);
        end
        else begin
            writeln (0);
        end
    end
end.
