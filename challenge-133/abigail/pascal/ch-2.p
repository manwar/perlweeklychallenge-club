Program ch2;

(*                  *)
(* See ../README.md *)
(*                  *)

(*                                                        *)
(* Run as: fpc -och-2.out ch-2.p; ./ch-2.out < input-file *)
(*                                                        *)

type
    factor_type = array of Integer;

const
    small_primes: Array of Integer =
                 (2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31);
    base  = 10;
    count = 10;

function factors (number: Integer): factor_type;
    var
        out: factor_type = ();
        index, prime: Integer;
        i: Integer = 0;

    begin
        for index := 0 to length (small_primes) - 1 do begin
            prime := small_primes [index];
            while number mod prime = 0 do begin
                setlength (out, i + 1);
                out [i] := prime;
                i := i + 1;
                number := number div prime;
            end;
        end;
        if number > 1 then begin
            setlength (out, i + 1);
            out [i] := number;
        end;

        factors := out;
    end;


function digitsum (numbers: Array of Integer): Integer;
    var
        sum: integer = 0;
        i, number: integer;

    begin
        for i := 0 to length (numbers) - 1 do begin
            number := numbers [i];
            while number > 0 do begin
                sum    := sum + (number mod base);
                number :=        number div base;
            end
        end;

        digitsum := sum;
    end;

var
    ff: factor_type;
    nn: array [0 .. 0] of integer;
    c: integer = count;
    n: integer = 1;

begin
    while c > 0 do begin
        inc (n);
        ff := factors (n);
        nn [0] := n;
        if (length (ff) > 1) and (digitsum (nn) = digitsum (ff)) then begin
            writeln (n);
            dec (c);
        end
    end
end.
