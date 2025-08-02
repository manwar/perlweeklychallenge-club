// Part 1

//with regex match and filter distinct

let splitRuns s = Regex("\d+").Matches(s) |> Seq.cast<Match> |> Seq.map (fun m -> m.Value) |> Seq.toList |> Seq.distinct
printfn "%A" (splitRuns "go21od1lu5c7k")
printfn "%A" (splitRuns "the1weekly2challenge2")
printfn "%A" (splitRuns "4p3e2r1l")
printf "\n"
