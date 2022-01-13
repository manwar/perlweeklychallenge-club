Program ch2;

(*                  *)
(* See ../README.md *)
(*                  *)

(*                                           *)
(* Run as: fpc -och-2.out ch-2.p; ./ch-2.out *)
(*                                           *)

var
    BASE:   integer = 10;
    COUNT:  integer =  5;
    number: integer =  1;

function is_long (number: integer): boolean;
    var
        seen: array of boolean;
        rest: integer;
        i:    integer;

    begin
        setlength (seen, number);
        for i := 0 to number - 1 do begin
            seen [i] := false;
        end;

        rest := 0;

        for i := 2 to number do begin
            rest := (rest * BASE + BASE - 1) mod number;
            if seen [rest] then begin
                exit (false);
            end;
            seen [rest] := true;
        end;

        exit (true);
    end;

begin
    while COUNT > 0 do begin
        inc (number);
        if BASE mod number = 0 then begin
            continue;
        end;
        if is_long (number) then begin
            writeln (number);
            dec (COUNT);
        end
    end
end.
