Program ch2;

(*                                                                   *)
(* See https://theweeklychallenge.org/blog/perl-weekly-challenge-149 *)
(*                                                                   *)

(*                                                        *)
(* Run as: fpc -och-2.out ch-2.p; ./ch-2.out < input-file *)
(*                                                        *)

var
    A287298: array [0 .. 22] of string;
    n: integer;

begin
    A287298 [ 0] :=                       '';
    A287298 [ 1] :=                       '';
    A287298 [ 2] :=                      '1';
    A287298 [ 3] :=                      '1';
    A287298 [ 4] :=                   '3201';
    A287298 [ 5] :=                   '4301';
    A287298 [ 6] :=                 '452013';
    A287298 [ 7] :=                '6250341';
    A287298 [ 8] :=               '47302651';
    A287298 [ 9] :=              '823146570';
    A287298 [10] :=             '9814072356';
    A287298 [11] :=            'A8701245369';
    A287298 [12] :=           'B8750A649321';
    A287298 [13] :=           'CBA504216873';
    A287298 [14] :=         'DC71B30685A924';
    A287298 [15] :=        'EDAC93B24658701';
    A287298 [16] :=       'FED5B39A42706C81';
    A287298 [17] :=       'GFED5A31C6B79802';
    A287298 [18] :=     'HGF80ADC53712EB649';
    A287298 [19] :=    'IHGFD3408C6E715A2B9';
    A287298 [20] :=   'JIHG03DAC457BFE96281';
    A287298 [21] :=                       '';
    A287298 [22] := 'LKJIG5D14B9032FHAC867E';

    while not eof do begin
        readln (n);
        if (n > 22) or (length (A287298 [n]) = 0) then begin
            writeln ('Too hard to calculate');
        end
        else begin
            writeln (A287298 [n]);
        end;
    end;
end.
