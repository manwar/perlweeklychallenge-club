let init lst =
  let rec helper lst acc =
    match lst with
    | [] | [_] -> List.rev acc
    | hd :: tl -> helper tl (hd :: acc) in
  helper lst []

let task1 s =
  let words = String.split_on_char ' ' s in
  let words = init (List.tl words) in
  print_int 
    (List.fold_left (fun len word -> len + (String.length word))
       0 words);
  print_newline()
  
let _ =
  task1 "The Weekly Challenge";
  task1 "The purpose of our lives is to be happy"
