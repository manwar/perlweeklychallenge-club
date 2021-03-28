Program NthRoot;

(*                                                                        *)
(* See ../README.md                                                       *)
(*                                                                        *)

(*                                                                        *)
(* Run as: fpc -och-1.out ch-1.p; ./ch-1.out                              *)
(*                                                                        *)

(*                                                                        *)
(* Input will consist of lines; each line will have two numbers, N and k, *)
(* N > 0, k > 0. For each line of input, we output a line with the Nth    *)
(* root of k.                                                             *)
(*                                                                        *)
(* We're not doing any input validations; we're assuming it's correct.    *)
(*                                                                        *)

(*                                                                        *)
(* To find the Nth root of a number k, we calculate:                      *)
(*                                                                        *)
(*        ln (k)                                                          *)
(*        ------                                                          *)
(*          N                                                             *)
(*    exp                                                                 *)
(*                                                                        *)
(*                         1/N                                            *)
(* which is equivalent to k                                               *)
(*                                                                        *)

var N, k: double;

begin
    while not eof () do
    begin
        readln (N, k);
        writeln (exp (ln (k) / N) : 1 : 10);
    end
end.
