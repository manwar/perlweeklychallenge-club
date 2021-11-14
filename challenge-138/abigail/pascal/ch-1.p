Program XXX;

(*                  *)
(* See ../README.md *)
(*                  *)

(*                                                        *)
(* Run as: fpc -och-1.out ch-1.p; ./ch-1.out < input-file *)
(*                                                        *)

const
    SUNDAY    = 0;
    MONDAY    = 1;
    TUESDAY   = 2;
    WEDNESDAY = 3;
    THURSDAY  = 4;
    FRIDAY    = 5;
    SATURDAY  = 6;

var
    anchors: Array [0 .. 3] of Integer = (
        TUESDAY, SUNDAY, FRIDAY, WEDNESDAY
    );
    lookup: Array [0 .. 1, 0 .. 6] of Integer = (
        (261, 261, 260, 260, 261, 261, 261),
        (262, 262, 261, 260, 261, 262, 262)
    );
    year: Integer;


function doomsday (year: Integer): Integer;
    var
        anchor, y: Integer;

    begin
        anchor   := anchors [(year div 100) mod 4];
        y        := year mod 100;
        doomsday := (((y div 12) + (y mod 12) +
                     ((y mod 12) div 4)) + anchor) mod 7;
    end;

function is_leap (year: Integer): Integer;
    begin
        if (year mod 400 = 0) or
          ((year mod   4 = 0) and (year mod 100 <> 0)) then begin
            is_leap := 1;
        end
        else begin
            is_leap := 0;
        end
    end;

begin
    while not eof do begin
        readln  (year);
        writeln (lookup [is_leap (year)] [doomsday (year)]);
    end
end.
