// 332 part 1

let inp_list1 = [| "2025-07-26";"2000-02-02"; "2024-12-31"|];

for i in inp_list1 do 
    let split = i.Split '-'
    for j in 0 .. (Seq.length(split))-1 do
        // conversion of int to Binary with "%B"
         printf "%B" (System.Int32.Parse(split[j]))
         if j <> (Seq.length(split))-1 then printf "%s" "-"
    printf "\n"
