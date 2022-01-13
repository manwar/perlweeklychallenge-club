Program XXX;

(*                  *)
(* See ../README.md *)
(*                  *)

(*                                                        *)
(* Run as: fpc -och-1.out ch-1.p; ./ch-1.out < input-file *)
(*                                                        *)

var
    n, size, j, half, sum: integer;
    numbers: array of integer;

begin
    (*                                  *)
    (* Read in data into a single array *)
    (*                                  *)
    size := 0;
    while not eof do begin
        read (n);
        inc (size);
        setlength (numbers, size);
        numbers [size - 1] := n;
    end;

    (*                           *)
    (* Calculate the dot product *)
    (*                           *)
    sum := 0;
    half := (size - 1) div 2;
    for j := 0 to half do begin
        sum := sum + numbers [j] * numbers [half + j];
    end;

    writeln (sum);
end.
