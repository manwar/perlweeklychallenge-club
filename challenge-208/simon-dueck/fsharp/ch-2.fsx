(*
    You are given an array of integers in sequence with one missing and one duplicate.

    Write a script to find the duplicate and missing integer in the given array.
    Return -1 if none found.

    For the sake of this task, let us assume the array
    contains no more than one duplicate and missing.
*)

let rec find_duplicate arr = // this is assuming the duplicates are consecutive
    match arr with
    | x::y::_ when x = y -> y
    | x::xs -> find_duplicate xs
    | _ -> -1

let rec find_missing arr =
    match arr with
    | x::y::_ when y - x = 2 -> y - 1
    | x::xs -> find_missing xs
    | _ -> -1

let arr = [1; 2; 3; 3; 4; 6; 7; 8; 9;]
printfn $"duplicate : {find_duplicate arr}\nmissing : {find_missing arr}"