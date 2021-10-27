Program XXX;

(*                  *)
(* See ../README.md *)
(*                  *)

(*                                                        *)
(* Run as: fpc -och-2.out ch-2.p; ./ch-2.out < input-file *)
(*                                                        *)

function count (target, this_fib, prev_fib: integer): integer;
    begin
             if target < this_fib then count := 0
        else if target = this_fib then count := 1
        else count := count (target - this_fib, this_fib + prev_fib, this_fib) +
                      count (target,            this_fib + prev_fib, this_fib);
    end;

var
    n: integer;

begin
    while (not eof) do begin
        readln (n);
        writeln (count (n, 1, 1));
    end
end.
