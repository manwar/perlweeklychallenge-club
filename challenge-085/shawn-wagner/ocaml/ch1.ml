open Base
open Stdio
open Combinat (* I had to build this one from git; the version in OPAM is too old *)

let sum lst = List.fold lst ~f:(+.) ~init:0.0

let task1 r =
  let combos = Combination.Of_list.create r 3 in
  print_endline
    (Combination.Of_list.fold_until
       combos
       ~f:(fun acc c ->
         let open Float in
         let total = sum c in
         if 1.0 < total && total < 2.0 then
           Stop "1"
         else
           Continue acc)
       ~init:"0"
       ~finish:(function acc -> acc))

let _ =
  task1 [1.2; 0.4; 0.1; 2.5];
  task1 [0.2; 1.5; 0.9; 1.1];
  task1 [0.5; 1.1; 0.3; 0.7]
