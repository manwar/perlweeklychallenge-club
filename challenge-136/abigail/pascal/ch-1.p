Program XXX;

(*                  *)
(* See ../README.md *)
(*                  *)

(*                                                        *)
(* Run as: fpc -och-1.out ch-1.p; ./ch-1.out < input-file *)
(*                                                        *)

(*                                                         *)
(* Find the GCD, using Stein's algorithm                   *)   
(*    (https://en.wikipedia.org/wiki/Binary_GCD_algorithm) *)
(*                                                         *)
function gcd (u, v: integer): integer;
    var
        u_odd, v_odd: boolean;

    begin
        u_odd := u mod 2 <> 0;
        v_odd := v mod 2 <> 0;

             if (u = v)   or (v = 0)    then gcd := u
        else if              (u = 0)    then gcd := v
        else if not u_odd and not v_odd then gcd := gcd (u >> 1, v >> 1) << 1
        else if not u_odd and     v_odd then gcd := gcd (u >> 1, v)
        else if     u_odd and not v_odd then gcd := gcd (u,      v >> 1)
        else if u > v                   then gcd := gcd (u - v,  v)
        else                                 gcd := gcd (v - u,  u);
    end;


(*                                                                 *)
(* Return true if number is a power of n, that is, number == n ^ p *)
(* for some non-negative integer p. Return false otherwise.        *)
(*                                                                 *)
function is_power_of_n (number, n: integer): boolean;
    begin
             if number < 1        then is_power_of_n := false
        else if number = 1        then is_power_of_n := true
        else if number mod n <> 0 then is_power_of_n := false
        else is_power_of_n := is_power_of_n (number div n, n);
    end;

function is_power_of_2 (number: integer): boolean;
    begin
        is_power_of_2 := is_power_of_n (number, 2);
    end;



var
    m, n, r: integer;

begin
    while (not eof) do begin
        readln (m, n);
        r := gcd (m, n);
        if (r > 1) and is_power_of_2 (r) then
            writeln (1)
        else
            writeln (0)
    end
end.
