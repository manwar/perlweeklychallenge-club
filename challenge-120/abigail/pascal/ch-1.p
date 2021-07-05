Program XXX;

(*                  *)
(* See ../README.md *)
(*                  *)

(*                                                        *)
(* Run as: fpc -och-1.out ch-1.p; ./ch-1.out < input-file *)
(*                                                        *)

var num: integer;

begin
    while true do begin
        readln (num);
        if num = 0 then begin
            break;
        end;
        writeln ((num and $55) shl 1 or
                 (num and $AA) shr 1);
    end
end.
