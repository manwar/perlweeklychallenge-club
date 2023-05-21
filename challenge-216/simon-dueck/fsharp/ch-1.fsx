(*
    You are given a list of words and a random registration number.
    Write a script to find all the words in the given list that has every letter in the given registration number.
*)

let word_contains_letter (word: string) (l: char): bool =
    if l >= 'a' && l <= 'z' then
        List.contains (char ((int l) - 32)) (Seq.toList word) // to uppercase
    elif l >= 'A' && l <= 'Z' then
        List.contains l (Seq.toList word)
    else true // l is not a letter

let rec word_contains_all_letters (word: string) (l: char list): bool =
    match l with
    | x::xs when word_contains_letter word x -> word_contains_all_letters word xs
    | [] -> true
    | _ -> false

let contains_all (words: string list) (plate: string): string list = 
    let rec loop (words:string list) (plate: char list) =
        match words with
        | word::xs when word_contains_all_letters (word.ToUpper()) plate -> word :: (loop xs plate)
        | _::xs -> loop xs plate
        | [] -> []
    loop words (plate |> Seq.toList)

let words_a = ["abc"; "abcd"; "bcd"]
let plate_a = "AB1 2CD"
let words_b = ["job"; "james"; "bjorg"]
let plate_b = "007 JB"
let words_c = ["crack"; "road"; "rac"]
let plate_c = "C7 RA2"

printfn "%A %s -> %A" words_a plate_a (contains_all words_a plate_a)
printfn "%A %s -> %A" words_b plate_b (contains_all words_b plate_b)
printfn "%A %s -> %A" words_c plate_c (contains_all words_c plate_c)
