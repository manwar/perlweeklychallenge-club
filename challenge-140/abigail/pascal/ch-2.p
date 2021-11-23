Program ch2;

(*                  *)
(* See ../README.md *)
(*                  *)

(*                                                        *)
(* Run as: fpc -och-2.out ch-2.p; ./ch-2.out < input-file *)
(*                                                        *)

uses
    math;

var
    i, j, k, n, s, d: longint;

begin
    while not eof do begin
        readln (i, j, k);

        n := 0;

        while k > 0 do begin
            inc (n);
            s := round (sqrt (n));
            for d := 1 to s do begin
                if n mod d = 0 then begin
                    if (d <= i) and (n / d <= j) then begin dec (k); end;
                    if (d <= j) and (n / d <= i) then begin dec (k); end;
                    if (n  = d * d)              then begin inc (k); end;
                end
            end
        end;
        writeln (n);
    end
end.
