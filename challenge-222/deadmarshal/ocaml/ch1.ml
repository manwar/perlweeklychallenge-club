let matching_numbers (lst:'int list):int =
  let rec aux lst1 lst2 acc =
    match (lst1,lst2) with
    | [],[] -> acc
    | [],_  -> acc
    | _,[]  -> acc
    | (h::t),(h2::t2) ->
      if h == h2 then aux t t2 (succ acc)
      else aux t t2 acc
  in
  let sorted = List.sort compare lst in
  aux lst sorted 0

let _ =
  [1;1;4;2;1;3] |> matching_numbers |> Printf.printf "%d\n";
  [5;1;2;3;4]   |> matching_numbers |> Printf.printf "%d\n";
  [1;2;3;4;5]   |> matching_numbers |> Printf.printf "%d\n"
  
