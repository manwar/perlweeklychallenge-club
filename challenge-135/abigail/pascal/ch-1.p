Program ch1;

(*                  *)
(* See ../README.md *)
(*                  *)

(*                                                        *)
(* Run as: fpc -och-1.out ch-1.p; ./ch-1.out < input-file *)
(*                                                        *)

uses
    RegExpr;

var
    line:     String;
    re_valid: TRegExpr;
    re_sign:  TRegExpr;
    len:      Integer;

begin
    re_valid := TRegExpr . Create ('^[-+]?[0-9]*$');
    re_sign  := TRegExpr . Create ('^[-+]');
    while not eof do begin
        readln (line);
        if not re_valid . Exec (line) then begin
            writeln ('not an integer');
            continue;
        end;
        if re_sign . Exec (line) then begin
            Delete (line, 1, 1);
        end;
        len := length (line);
        if len mod 2 = 0 then begin
            writeln ('even number of digits');
            continue;
        end;
        if len < 3 then begin
            writeln ('too short');
            continue;
        end;
        writeln (copy (line, 1 + ((len - 3) div 2), 3));
    end
end.
