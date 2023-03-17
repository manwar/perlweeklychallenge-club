(*
    You are given an array of words.
    Write a script to print all the words in the given array that
    can be types using alphabet on only one row of the keyboard.
    Let us assume the keys are arranged as below:
*)

let keyboard: string list =
    ["qwertyuiopQWERTYUIOP"; "asdfghjklASDFGHJKL"; "zxcvbnmZXCVBNM";]

let rec contains_letter (l: char) (str: string) =
    if str.Length = 0 then false
    elif str.[0] = l then true
    else contains_letter l str.[1..]

let rec is_subset (letters: string) (word: string) =
    if word.Length = 0 then
        true
    elif (contains_letter word.[0] letters) then
        is_subset letters word.[1..]
    else
        false

let single_row_words (words: string list) (layout: string list) =
    let mutable output: list<string> = []
    for word in words do
        for row in layout do
            if is_subset row word then
                output <- word :: output
    output

let words = single_row_words ["Hello"; "Alaska"; "Dad"; "Peace"] keyboard
printfn $"{words}"
