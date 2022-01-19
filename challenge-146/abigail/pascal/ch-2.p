Program ch2;

(*                  *)
(* See ../README.md *)
(*                  *)

(*                                                        *)
(* Run as: fpc -och-2.out ch-2.p; ./ch-2.out < input-file *)
(*                                                        *)

uses
    sysutils;

var
    line: string;
    a, b: integer;
    i, x: integer;

begin
    while not eof do begin
        readln (line);
        x := pos ('/', line);
        a := strtoint (copy (line, 1, x - 1));
        b := strtoint (copy (line, x + 1, length (line) - x));
        for i := 1 to 2 do begin
            if a < b then begin
                b := b - a;
            end
            else begin
                a := a - b;
            end;
            if (a = 0) or (b = 0) then begin
                break;
            end;
            write (a);
            write ('/');
            write (b);
            write (' ');
        end;
        writeln ('');
    end
end.
