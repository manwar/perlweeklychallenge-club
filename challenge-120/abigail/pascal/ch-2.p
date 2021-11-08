Program ClockAngle;

(*                  *)
(* See ../README.md *)
(*                  *)

(*                                                        *)
(* Run as: fpc -och-2.out ch-2.p; ./ch-2.out < input-file *)
(*                                                        *)

uses sysutils;

var
    time: string;
    hours, minutes, angle: integer;

const
    DIFF_PER_MINUTE =  11;
    MIN_PER_HOUR    =  60;
    FULL_CIRCLE     = 720;

begin
    while not eof () do begin
        (*                           *)
        (* Read and parse the input. *)
        (*                           *)
        readln (time);
        hours   := strtoint (leftstr  (time, 2));
        minutes := strtoint (rightstr (time, 2));

        (*                                      *)
        (* Calculate the angle in half degrees. *)
        (*                                      *)
        angle := (DIFF_PER_MINUTE * (hours * MIN_PER_HOUR + minutes)) mod
                                             FULL_CIRCLE;

        (*                           *)
        (* We want the convex angle. *)
        (*                           *)
        if 2 * angle >= FULL_CIRCLE then begin
            angle := FULL_CIRCLE - angle;
        end;

        (*                                                     *)
        (* Output. First we output the integer part. If the    *)
        (* number of half degrees is odd, add a trailing '.5'. *)
        (*                                                     *)
        write (angle div 2);
        if angle mod 2 = 1 then begin
            write ('.5');
        end;
        writeln ('');
    end
end.
