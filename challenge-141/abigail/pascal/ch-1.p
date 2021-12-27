Program XXX;

(*                  *)
(* See ../README.md *)
(*                  *)

(*                                           *)
(* Run as: fpc -och-1.out ch-1.p; ./ch-1.out *)
(*                                           *)

var
    count:          integer = 10;
    nr_of_divisors: integer =  8;
    n, s, d, c:     integer;


begin
    n := 0;
    while count > 0 do begin
        inc (n);
        s := round (sqrt (n));
        if n = s * s then begin
            continue;
        end;
        c := 0;
        for d := 1 to s do begin
            if n mod d = 0 then begin
                c := c + 2;
                if c > nr_of_divisors then begin
                    continue;
                end
            end
        end;
        if c = nr_of_divisors then begin
            writeln (n);
            dec (count);
        end
    end
end.
