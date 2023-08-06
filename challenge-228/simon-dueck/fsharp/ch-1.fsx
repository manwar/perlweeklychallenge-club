(*
    You are given an array of integers.
    Write a script to find out the sum of unique elements in the given array.
*)
        
let rec remove_dupes (arr: 'a list) =
    match arr with
    | x::xs when List.contains x xs -> remove_dupes <| List.except (seq {x}) xs
    | x::xs -> x :: remove_dupes xs
    | [] -> []


let print_list arr =
    printf "[ "
    for item in arr do
        printf $"{item}; "
    printf "]"


let a = [2; 1; 3; 2;]
print_list a
printfn " -> %d" (List.sum <| remove_dupes a)

let b = [1; 1; 1; 1;]
print_list b
printfn " -> %d" (List.sum <| remove_dupes b)

let c = [2; 1; 3; 4;]
print_list c
printfn " -> %d" (List.sum <| remove_dupes c)

let d = [
    31; 41; 81; 91; 42; 11; 60; 12; 82; 61;
    14; 32; 71; 62; 34; 43; 13; 01; 50; 44;
    14; 32; 71; 62; 34; 43; 13; 01; 50; 44;
    72; 45; 21; 04; 63; 94; 02; 83; 93; 46;
    72; 45; 21; 04; 63; 94; 02; 83; 93; 46;
    19; 33; 15; 84; 92; 95; 03; 73; 47; 64;
    18; 17; 65; 16; 97; 96; 48; 10; 99; 00;
    ]
print_list d
printfn " -> %d" (List.sum <| remove_dupes d)