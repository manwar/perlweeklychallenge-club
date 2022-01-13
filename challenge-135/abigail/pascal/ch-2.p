Program XXX;

(*                  *)
(* See ../README.md *)
(*                  *)

(*                                                        *)
(* Run as: fpc -och-2.out ch-2.p; ./ch-2.out < input-file *)
(*                                                        *)

uses
    RegExpr;

const
    ord_0 = Ord ('0');
    ord_9 = Ord ('9');
    ord_A = Ord ('A');
    w     : Array [0 .. 6] of Integer = (1, 3, 1, 7, 3, 9, 1);

var
    sedol: String;
    valid: TRegExpr;
    check: Integer;
    c:     Char;
    val:   Integer;
    index: Integer;

begin
    valid := TRegExpr . Create ('^[0-9BCDFGHJKLMNPQRSTVWXYZ]{6}[0-9]$');
    while not eof do begin
        readln (sedol);
        if not valid . Exec (sedol) then begin
            writeln (0);
            continue;
        end;
        check := 0;
        index := 0;
        for c in sedol do begin
            val := Ord (c);
            if val <= ord_9 then begin
                val := val - ord_0;
            end
            else begin
                val := val - ord_A;
            end;
            check := check + val * w [index];
            inc (index);
        end;
        if check mod 10 = 0 then begin
            writeln (1);
        end
        else begin
            writeln (0);
        end
    end
end.
