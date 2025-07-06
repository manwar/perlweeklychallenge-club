open System
let example = "a?z"
let rnd = new Random()

// choose random a-z
let rnd_char = ['a' .. 'z'].[rnd.Next(0, 25) ]

// tailcall rec newchar; if n=x repeat newchar with new randomchar
[<TailCall>]
let rec newchar n x = if n=x then newchar rnd_char x else printfn "%c" n
// iterate over string
String.iter (fun x -> if x <> '?' then printfn "%c" x else newchar rnd_char x) example
