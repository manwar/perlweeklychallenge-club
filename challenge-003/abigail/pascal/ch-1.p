Program ch1;

(*                                                                   *)
(* See https://theweeklychallenge.org/blog/perl-weekly-challenge-003 *)
(*                                                                   *)

(*                                                        *)
(* Run as: fpc -och-1.out ch-1.p; ./ch-1.out < input-file *)
(*                                                        *)

var
    max, count, next_2, next_3, next_5: integer;
    min, c2, c3, c5: qword;
    ugly: array of qword;

begin
    while not eof do begin
        readln (max);
        setlength (ugly, max);

        ugly [0] := 1;
        count    := 0;
        next_2   := 0;
        next_3   := 0;
        next_5   := 0;
        min      := 0;

        while count < max - 1 do begin
            inc (count);

            c2 := 2 * ugly [next_2];
            c3 := 3 * ugly [next_3];
            c5 := 5 * ugly [next_5];

            if (c2 <= c3) and (c2 <= c5) then begin min := c2; end;
            if (c3 <= c2) and (c3 <= c5) then begin min := c3; end;
            if (c5 <= c2) and (c5 <= c3) then begin min := c5; end;

            ugly [count] := min;

            if c2 <= ugly [count] then begin inc (next_2); end;
            if c3 <= ugly [count] then begin inc (next_3); end;
            if c5 <= ugly [count] then begin inc (next_5); end;
        end;

        writeln (ugly [count]);
    end
end.
