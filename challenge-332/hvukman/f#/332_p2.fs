// 332 part 2
let inp_list = [| "weekly"; "perl"; "challenge"|];
                
let odd x = Seq.toList x |>
                // go over Seq and filter not equal characters
                List.map (fun y -> String.filter (fun z -> y=z ) x) |>
                // check if unique characters are in list in multiple of two
                List.filter (fun w -> String.length(w)%2=0) 

for i in inp_list do
    if List.length(odd i)>0 then printf "false\n" else printf "true\n"
