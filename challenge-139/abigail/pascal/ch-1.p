Program ch1;

(*                  *)
(* See ../README.md *)
(*                  *)

(*                                                        *)
(* Run as: fpc -och-1.out ch-1.p; ./ch-1.out < input-file *)
(*                                                        *)

var
    prev, next: integer;
    sorted: integer;

begin
    while not eof do begin
        sorted := 1;
        read (prev);
        while not eoln do begin
            read (next);
            if prev > next then begin
                sorted := 0;
            end;
            prev := next;
        end;
        readln ();
        writeln (sorted);
    end;
end.
