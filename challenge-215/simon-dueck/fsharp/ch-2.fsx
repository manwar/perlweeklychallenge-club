(*
    You are given a list of numbers having just 0 and 1. You are also given placement count (>=1).

    Write a script to find out if it is possible to replace 0 with 1 in the given list.
    The only condition is that you can only replace when there is no 1 on either side.
    Print 1 if it is possible otherwise 0.
*)

let rec replace_zero (arr: int list) (count: int): int = 
    match arr with
    | _ when count = 0 -> 1                     // all are placed
    | 0::0::xs -> replace_zero xs (count - 1)   // can replace; skip next index as it will not be replaceable
    | [0] -> replace_zero [] (count - 1)        // end of the list is zero and replacable
    | 1::0::xs -> replace_zero xs count         // current and next index are not replaceable
    | _::xs -> replace_zero xs count            // current index is not replaceable but next potentially is or is a one
    | _ -> 0                                    // end of list with count not reaching zero

let numbers_a = [1; 0; 0; 0; 1]
let numbers_b = [1; 0; 0; 0; 1]
let numbers_c = [1; 0; 0; 0; 0; 0; 0; 0; 1]
let numbers_d = [1; 0; 0; 0; 1; 0; 0; 1]

printfn $"{replace_zero numbers_a 1}"
printfn $"{replace_zero numbers_b 2}"
printfn $"{replace_zero numbers_c 3}"
printfn $"{replace_zero numbers_d 2}"