Program XXX;

(*                  *)
(* See ../README.md *)
(*                  *)

(*                                                        *)
(* Run as: fpc -och-1.out ch-1.p; ./ch-1.out < input-file *)
(*                                                        *)

uses
    math;

var
   n, n_sq, a, max_a, b, b_sq, c, c_sq: int64;

function introot (square: int64): int64;
begin
    introot := round (sqrt (square));
end;


begin
    while (not eof) do begin
        readln (n);
        if n <= 2 then begin
            writeln (-1);
            continue;
        end;

        n_sq := n * n;
        c    := n + 1;
        c_sq := n_sq + 2 * n + 1;

        while (2 * c - 1 <= n_sq) do begin
            b_sq := c_sq - n_sq;
            b    := introot (b_sq);
            if b_sq = b * b then begin
                writeln (n, ' ', b, ' ', c);
            end;
            c_sq := c_sq + 2 * c + 1;
            c    := c + 1;
        end;

        max_a := floor (n / sqrt (2));
        for a := 3 to max_a do begin
            b_sq := n_sq - a * a;
            if b_sq < 0 then begin
                writeln ('n = ', n, '; a = ', a, '; b_sq = ', b_sq);
                continue;
            end;

            b    := introot (b_sq);
            if b_sq = b * b then begin
                writeln (a, ' ', b, ' ', n);
            end;
        end;
    end;
end.
