Program ch2;

(*                                                                   *)
(* See https://theweeklychallenge.org/blog/perl-weekly-challenge-148 *)
(*                                                                   *)

(*                                           *)
(* Run as: fpc -och-2.out ch-2.p; ./ch-2.out *)
(*                                           *)

const
    COUNT = 5;
    Ai    = 0;
    Bi    = 1;
    Ci    = 2;
    SUMi  = 3;

var
    out: array [0 .. (COUNT - 1), Ai .. SUMi] of longword;
    d1, d2: array of longword;
    i, j, k, l, a, b, c, f1, f2, s1, s2: longword;
    max_index: integer;
    max_sum: longword;
    seen: boolean;

begin
    for i := 0 to COUNT - 1 do begin
        out [i, Ai]   := 999999;
        out [i, Bi]   := 999999;
        out [i, Ci]   := 999999;
        out [i, SUMi] := out [i, Ai] + out [i, Bi] + out [i, Ci];
    end;

    max_index := 0;

    k := 0;
    while 3 * k + 2 <= out [max_index, SUMi] do begin
        a  := 3 * k + 2;
        f1 :=     k + 1;
        f2 := 8 * k + 5;

        setlength (d1, 0);
        setlength (d2, 0);

        (*                     *)
        (* Find divisors of f1 *)
        (*                     *)
        i := 1;
        while i * i <= f1 do begin
            if f1 mod i = 0 then begin
                setlength (d1, 1 + length (d1));
                d1 [length (d1) - 1] := i;
                if i <> (f1 div i) then begin
                    setlength (d1, 1 + length (d1));
                    d1 [length (d1) - 1] := f1 div i;
                end;
            end;
            inc (i);
        end;

        (*                            *)
        (* Find square divisors of f2 *)
        (*                            *)
        i := 1;
        while i * i <= f2 do begin
            if f2 mod i = 0 then begin
                s1 := round (sqrt (i));
                s2 := round (sqrt (f2 div i));

                if s1 * s1 = i then begin
                    setlength (d2, 1 + length (d2));
                    d2 [length (d2) - 1] := s1;
                end;

                if s2 * s2 = f2 div i then begin
                    setlength (d2, 1 + length (d2));
                    d2 [length (d2) - 1] := s2;
                end;
            end;
            inc (i);
        end;

        for i := 0 to length (d1) - 1 do begin
            for j := 0 to length (d2) -1 do begin
                b := d1 [i] * d2 [j];
                c := f1 * f1 * f2 div (b * b);
                if a + b + c < out [max_index, SUMi] then begin
                    seen := false;
                    for l := 0 to COUNT - 1 do begin
                        if (out [l, Ai] = a) and (out [l, Bi] = b) then begin
                            seen := true;
                        end;
                    end;
                    if seen then begin
                        break;
                    end;

                    out [max_index, Ai]   := a;
                    out [max_index, Bi]   := b;
                    out [max_index, Ci]   := c;
                    out [max_index, SUMi] := a + b + c;

                    max_index := 0;
                    max_sum   := out [max_index, SUMi];

                    for l := 1 to COUNT - 1 do begin
                        if max_sum < out [l, SUMi] then begin
                            max_index := l;
                            max_sum   := out [l, SUMi];
                        end;
                    end;
                end;
            end;
        end;
        inc (k);
    end;

    for i := 0 to COUNT - 1 do begin
        writeln (out [i, Ai], ' ', out [i, Bi], ' ', out [i, Ci]);
    end;
end.
