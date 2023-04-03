(*
    You are given an array of binary bits that ends with 0.
    Valid sequences in the bit string are:
    [0] -decodes-to-> "a"
    [1, 0] -> "b"
    [1, 1] -> "c"
    Write a script to print 1 if the last character is an “a” otherwise print 0.
*)

let rec decode (arr): int =
    match arr with
    | [x] when not x -> 1 // last character decodes to 'a'
    | x::y::xs when x -> decode xs // list begins with 'b' or 'c'
    | x::xs when not x -> decode xs // list begins with 'a'
    | _ -> 0

printfn $"{decode [true; true; false; false; true; false; false;]}"
printfn $"{decode [true; true; false; false; true; false;]}"