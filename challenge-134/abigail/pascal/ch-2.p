Program XXX;

(*                  *)
(* See ../README.md *)
(*                  *)

(*                                                        *)
(* Run as: fpc -och-2.out ch-2.p; ./ch-2.out < input-file *)
(*                                                        *)

var
    n, m, i, j, count: integer;
    seen: array of integer;

begin
    while (not eof) do begin
        readln (n, m);
        setLength (seen, n * m);
        for i := 1 to n * m do begin
            seen [i] := 0;
        end;
        count := 0;
        for i := 1 to n do begin
            for j := 1 to m do begin
                if seen [i * j] = 0
                then begin
                    count := count + 1;
                    seen [i * j] := 1;
                end
            end
        end;
        writeln (count);
    end
end.
