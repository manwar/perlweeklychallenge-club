// Part 2
let exists (x,y:String)  = y.IndexOf(Char.ToUpper x:char) <> -1 && y.IndexOf(Char.ToLower x:char) <> -1
String.iter (fun x -> if exists (x,"YaaAho") then printf "%c" x  ) "YaaAho"
printf "\n"
String.iter (fun x -> if exists (x,"cC") then printf "%c" x  ) "cC"
printf "\n"
String.iter (fun x -> if exists (x,"a") then printf "%c" x  ) "a"
