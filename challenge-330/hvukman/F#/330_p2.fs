// Part 2
let words = "PERL IS gREAT".Split(" ")

let print_right n = if Seq.length(n)>2 then printf "%c" (Char.ToUpper(Seq.head(n))) else printf "%c" (Char.ToLower(Seq.head(n)))
                    for p in (Seq.tail(n)) do printf "%c" (Char.ToLower(p))
                    printf " "


for m in "PERL IS gREAT".Split(" ") do print_right m
printf "\n"
for m in "THE weekly challenge".Split(" ") do print_right m
printf "\n"
for m in "YoU ARE A stAR".Split(" ") do print_right m
