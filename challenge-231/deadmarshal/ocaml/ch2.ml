let senior_citizens list =
  let rec aux lst count =
    match lst with
    | [] -> count
    | hd :: tl ->
       if int_of_string (String.sub hd (String.length hd-4) 2) >= 60 then
         aux tl (succ count)
       else
         aux tl count
  in
  aux list 0

let _ = 
  ["7868190130M7522";"5303914400F9211";"9273338290F4010"]
  |> senior_citizens
  |> Printf.printf "%d\n";
  ["1313579440F2036";"2921522980M5644"]
  |> senior_citizens
  |> Printf.printf "%d\n"
  
