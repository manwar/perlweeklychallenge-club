(*
    You are given a n x n matrix where n >= 2.
    Write a script to find 3rd smallest element in the sorted matrix.
*)

let sort_matrix (matrix: int list list): int =
    let rec loop matrix = 
        match matrix with
        | x::xs -> x @ loop xs
        | [] -> []
    in let sorted = loop matrix |> List.sort
    sorted[2]

printfn $"{sort_matrix [[1;2;3];[2;3;4];[6;7;8];]}" 