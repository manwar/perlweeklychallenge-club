(*
    You are given an array of integers in which all elements are unique.
    Write a script to perform the following operations until the array is empty and return the total count of operations.
*)

let operate arr =

    let rec loop count arr =
        match arr with
        | x::xs when x = List.min arr -> loop (count + 1) xs
        | x::xs -> loop (count + 1) (xs @ [x])
        | [] -> count

    loop 0 arr

let print_list arr =
    printf "[ "
    for item in arr do
        printf $"{item}; "
    printf "]"

let a = [3; 4; 2;]
print_list a
printfn " -> %d" (operate a)

let b = [1; 2; 3;]
print_list b
printfn " -> %d" (operate b)

let c = [
    31; 41; 81; 91; 42; 11; 60; 12; 82; 61;
    14; 32; 71; 62; 34; 43; 13; 01; 50; 44;
    72; 45; 21; 04; 63; 94; 02; 83; 93; 46;
    19; 33; 15; 84; 92; 95; 03; 73; 47; 64;
    18; 17; 65; 16; 97; 96; 48; 10; 99; 00;
    ]
print_list c
printfn " -> %d" (operate c)