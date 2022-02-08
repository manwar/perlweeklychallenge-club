Program ch2;

(*                                                                   *)
(* See https://theweeklychallenge.org/blog/perl-weekly-challenge-151 *)
(*                                                                   *)

(*                                                        *)
(* Run as: fpc -och-2.out ch-2.p; ./ch-2.out < input-file *)
(*                                                        *)

uses
    math;

var
    h: array of integer;
    i, sz: integer;

begin
    while not eof do begin
        sz := 0;
        setlength (h, sz);

        while not eoln do begin
            inc (sz);
            setlength (h, sz);
            read (h [sz - 1]);
        end;

        setlength (h, sz + 2);
        h [sz + 0] := 0;
        h [sz + 1] := 0;

        for i := sz - 1 downto 2 do begin
            h [i] := max (h [i] + h [i + 2], h [i + 1]);
        end;

        writeln (h [0] + h [2]);

        readln;
    end
end.
