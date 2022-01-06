Program ch2;

(*                                                                   *)
(* See https://theweeklychallenge.org/blog/perl-weekly-challenge-003 *)
(*                                                                   *)

(*                                                        *)
(* Run as: fpc -och-2.out ch-2.p; ./ch-2.out < input-file *)
(*                                                        *)

var
    max: integer;
    row, col: integer;
    current_row, next_row: array of integer;

begin
    while not eof do begin
        readln (max);
        setlength (current_row, 1);
        current_row [0] := 1;
        writeln (1);

        for row := 1 to max do begin
            setlength (next_row, row + 1);
            next_row [0]   := 1;
            next_row [row] := 1;
            write ('1 ');
            for col := 1 to row - 1 do begin
                next_row [col] := current_row [col - 1] + current_row [col];
                write (next_row [col], ' ');
            end;
            writeln ('1');
            current_row := next_row;
        end
    end
end.
