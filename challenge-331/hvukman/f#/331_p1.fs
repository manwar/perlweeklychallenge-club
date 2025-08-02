// part 1
// Trim white space, split at space, take last and length
printf "part 1\n"
let lastword (x:string) = x.Trim(' ').Split(" ") |> Array.last |> String.length
printf "%i\n" (lastword "The Weekly Challenge")
printf "%i\n" (lastword " hello world    ")
printf "%i\n" (lastword "Let's begin the fun")
