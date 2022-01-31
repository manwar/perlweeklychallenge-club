Program ch1;

(*                                                                   *)
(* See https://theweeklychallenge.org/blog/perl-weekly-challenge-149 *)
(*                                                                   *)

(*                                                        *)
(* Run as: fpc -och-1.out ch-1.p; ./ch-1.out < input-file *)
(*                                                        *)

uses
    fgl;

type
    fib_t = longint;

var
    n, k: integer;
    fib_prev: fib_t;
    fib_last: fib_t;
    fib: specialize TFPGMap <fib_t, boolean>;

function digit_sum (n: longint): integer;
    const
        base = 10;

    var
        sum: integer;

    begin
        sum := 0;
        while n > 0 do begin
            sum := sum + (n mod base);
            n   := n div base;
        end;
        digit_sum := sum;
    end;

procedure init_fib;
    begin
        fib      := specialize TFPGMap <fib_t, boolean> . Create;
        fib_prev := 0;
        fib_last := 1;
        fib . Add (fib_prev, true);
        fib . Add (fib_last, true);
    end;

function is_fib (n: fib_t): boolean;
    var
        t: fib_t;

    begin
        while fib_last < n do begin
            t        := fib_last;
            fib_last := fib_prev + fib_last;
            fib_prev := t;

            fib . Add (fib_last, true);
        end;

        is_fib := fib . IndexOf (n) >= 0;
    end;

begin
    init_fib;
    while not eof do begin
        readln (n);
        k := 0;
        while n > 0 do begin
            if is_fib (digit_sum (k)) then begin
                write (k, ' ');
                dec (n);
            end;
            inc (k);
        end;
        writeln ('');
    end;
end.
