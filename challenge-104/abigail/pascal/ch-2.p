Program NIM;

(*                  *)
(* See ../README.md *)
(*                  *)

(*                                           *)
(* Run as: fpc -och-2.out ch-2.p; ./ch-2.out *)
(*                                           *)

var tokens:   integer = 12;
var max_take: integer =  3;
var take:     integer;
var takes:    integer;

begin
    while tokens > 0 do
    begin
        write ('How many tokens do you take? (');
        if tokens < 10 then
            write (' ');
        write (tokens);
        write (' tokens are left) ');

        readln (take);   (* This will give a run-time error if a *)
                         (* non-numeric value is given as input. *)
        if (1 <= take) and (take <= max_take) then
        begin
            takes := max_take + 1 - take;
            write ('Computer takes ');
            write (takes);
            if takes <> 1 then
                writeln (' tokens')
            else
                writeln (' token');

            tokens := tokens - (max_take + 1);
        end
    end;

    writeln ('Computer wins');
end.
