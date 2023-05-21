(*
    You are given a list of words (alphabetic characters only) of same size.

    Write a script to remove all words not sorted alphabetically and print
    the number of words in the list that are not alphabetically sorted.
*)

let word_is_not_sorted (word: string): bool =
    let rec loop (letters: char list): bool =
        match letters with
        | x::y::xs when x < y -> loop (y::xs)
        | [x] -> false
        | _ -> true
    in loop (Seq.toList word)

let count_unsorted (words: string list): int =
    List.filter word_is_not_sorted words |> List.length


let words_a = ["abc"; "xyz"; "tsu"]
printfn $"{count_unsorted words_a}"

let words_b = ["rat"; "cab"; "dad"]
printfn $"{count_unsorted words_b}"

let words_c = ["x"; "y"; "z"]
printfn $"{count_unsorted words_c}"
