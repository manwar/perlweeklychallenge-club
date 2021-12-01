Program XXX;

(*                  *)
(* See ../README.md *)
(*                  *)

(*                                                        *)
(* Run as: fpc -och-2.out ch-2.p; ./ch-2.out < input-file *)
(*                                                        *)

uses
    sysutils;

function substrings (n: string; m, prefix, max: integer): integer;
    var
        fc, n_prefix: integer;
        tail: string;

    begin
        if length (n) = 0 then begin
            if (prefix > -1)  and
               (prefix < max) and
               (prefix mod m = 0) then begin
                substrings := 1;
            end
            else begin
                substrings := 0;
            end;
        end
        else begin
            fc := strtoint (copy (n, 1, 1));
            if prefix = -1 then begin
                n_prefix := fc;
            end
            else begin
                n_prefix := 10 * prefix + fc;
            end;

            tail := copy (n, 2, length (n));

            substrings := substrings (tail, m, n_prefix, max) +
                          substrings (tail, m,   prefix, max);
        end
    end;

var
    n, m: Integer;

begin
    while not eof do begin
        readln (n, m);
        writeln (substrings (inttostr (n), m, -1, n));
    end;
end.
