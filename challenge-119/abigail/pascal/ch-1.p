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
        writeln ((num and not $FF)       or
                 (num and     $0F) shl 4 or
                 (num and     $F0) shr 4);
    end
end.
