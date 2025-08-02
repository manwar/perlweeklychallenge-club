let str = "cab12"
let pat = "[A-Za-z]\d"
[<TailCall>]
let rec rec_repl n = if Regex.Match(n,pat).Success=true then rec_repl (Regex.Replace(n,pat,"")) else printf "%s\n" n 
rec_repl "cab12"
rec_repl "xy99"
rec_repl "pa1erl"
