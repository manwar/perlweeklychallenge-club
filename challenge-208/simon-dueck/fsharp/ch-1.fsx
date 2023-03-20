(*
    You are given two arrays of strings.
    Write a script to find out all common strings in the given two arrays with minimum index sum.
    If no common strings found returns an empty list.
*)

let rec contains arr elem =
    match arr with
    | x::xs when x = elem -> true
    | [] -> false
    | _ -> contains arr.Tail elem

let find_common arr_a arr_b =
    let rec inner arr_a arr_b acc =
        if arr_b = [] then
            acc
        elif contains arr_a arr_b.Head then
            inner arr_a arr_b.Tail (arr_b.Head :: acc)
        else
            inner arr_a arr_b.Tail acc
    inner arr_a arr_b []

let index_of arr item =
    let rec index_of_rec arr item index =
        match arr with
        | x::xs when x = item -> index
        | x::xs -> index_of_rec xs item (index + 1)
        | _ -> -1
    index_of_rec arr item 0

let index_sum item arr_a arr_b =
    index_of arr_a item + index_of arr_b item

let min_index_sum arr_a arr_b =
    
    let rec inner arr_a arr_b common min acc =
        match common with
        | [] -> acc
        | _ ->
            let curr = index_sum (common.Head) arr_a arr_b
            match curr with
            | x when x < min -> inner arr_a arr_b common.Tail curr [common.Head;]
            | x when x = min -> inner arr_a arr_b common.Tail curr (common.Head :: acc)
            | _ -> acc

    inner arr_a arr_b (find_common arr_a arr_b) (arr_a.Length) []

let arr_a = ["A"; "B"; "C";]
let arr_b = ["C"; "A"; "B";]
printfn $"arrays: {arr_a} {arr_b}\nminimum sum index : {min_index_sum arr_a arr_b}"