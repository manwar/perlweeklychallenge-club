Program XXX;

(*                  *)
(* See ../README.md *)
(*                  *)

(*                                                        *)
(* Run as: fpc -och-2.out ch-2.p; ./ch-2.out < input-file *)
(*                                                        *)

function _count (target, this_fib, prev_fib: integer): integer;
    begin
             if target < this_fib then _count := 0
        else if target = this_fib then _count := 1
        else _count := _count (target - this_fib, this_fib + prev_fib, this_fib)
                     + _count (target,            this_fib + prev_fib, this_fib)
    end;

function count (target: integer): integer;
    begin
        count := _count (target, 1, 1);
    end;

var
    n: integer;

begin
    while (not eof) do begin
        readln (n);
        writeln (count (n));
    end
end.
