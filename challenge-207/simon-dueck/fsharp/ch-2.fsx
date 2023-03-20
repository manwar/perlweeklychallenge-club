(*
    You are given an array of integers containing citations a researcher has received for each paper.
    Write a script to compute the researcher’s H-Index.
    For more information please checkout the wikipedia page.
    
    The H-Index is the largest number h such that h articles have at least h citations each.
    For example, if an author has five publications, with 9, 7, 6, 2, and 1 citations (ordered
    from greatest to least), then the author’s h-index is 3, because the author has three
    publications with 3 or more citations. However, the author does not have four publications
    with 4 or more citations.
*)

let rec reverse (arr: int list): int list =
    match arr with
    | [x] -> [x]
    | x::xs -> (reverse xs) @ [x]
    | _ -> []

let h_index (arr: int list) =
    if arr.Length = 0 then
        0
    else
        let sorted = arr |> List.sort |> reverse 
        
        let rec find_index (arr: int list) (index: int): int =
            match arr with
            | [] -> index - 1
            | x::xs when x >= index -> find_index xs (index + 1)
            | _ -> index

        find_index sorted 0

//[1; 4; 5; 3; 6; 1; 2; 6; 9; 4; 0;] [3; 3; 3; 4; 5;]

printfn $"{h_index [1; 4; 5; 3; 6; 1; 2; 6; 9; 4; 0;]}"