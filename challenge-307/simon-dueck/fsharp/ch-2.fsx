(*
    You are given a list of words, @words.
    Write a script to find any two consecutive words and if they are anagrams,
    drop the first word and keep the second.
    You continue this until there is no more anagrams in the given list and return the count of final list.
*)

let is_anagram (a: string) (b: string) =
    Seq.length (set [ yield! a; yield! b]) = a.Length

let find_anagrams words =
    let rec loop words =
        match words with
        | x::y::xs when is_anagram x y -> loop (x::xs)
        | x::xs -> x::(loop xs)
        | x -> x
    in words |> loop |> Seq.length

let words = ["acca"; "dog"; "god"; "perl"; "repl"]

find_anagrams words