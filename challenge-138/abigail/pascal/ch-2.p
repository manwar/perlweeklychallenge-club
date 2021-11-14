Program ch2;

(*                  *)
(* See ../README.md *)
(*                  *)

(*                                                        *)
(* Run as: fpc -och-2.out ch-2.p; ./ch-2.out < input-file *)
(*                                                        *)

function can_split (target: longint; number: longint): boolean;
    var
        pow_10: longint;
    begin
        if (target > number) or (target < 0) then begin
            can_split := false;
            exit;
        end;
        if (target = number) then begin
            can_split := true;
            exit;
        end;

        pow_10 := 10;

        while pow_10 <= number do begin
            if can_split (target - (number mod pow_10),
                                    number div pow_10) then begin
                can_split := true;
                exit;
            end;

            pow_10 := pow_10 * 10;
        end;

        can_split := false;
        exit;
    end;

var
    number: longint;

begin
    while not eof do begin
        readln  (number);
        if (number > 1) and can_split (round (sqrt (number)), number) then
            writeln (1)
        else
            writeln (0)
    end
end.
