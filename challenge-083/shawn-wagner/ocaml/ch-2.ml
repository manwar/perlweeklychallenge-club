let rec combinations lst =
  match lst with
  | [] -> []
  | [x] -> [ [ x ]; [ -x ] ]
  | hd :: tl ->
    let subs = combinations tl in
    List.append
      (List.map (function sub -> hd :: sub) subs)
      (List.map (function sub -> -hd :: sub) subs)

let sum = List.fold_left (fun acc i -> acc + i) 0

let task2 lst =
  let combos = combinations lst in
  let sums = List.map (function combo -> ((sum combo), combo)) combos in
  let possums = List.filter (function (total, _) -> total > 0) sums in
  let minsum = List.fold_left
      (fun (minsum, mincombo) (thissum, thiscombo) ->
         if thissum < minsum then thissum, thiscombo else minsum, mincombo)
      (Int.max_int, []) possums in
  let len = List.fold_left
      (fun acc elem -> if elem < 0 then acc + 1 else acc) 0 (snd minsum) in
  print_int len;
  print_newline ()

let _ = 
  task2 [3; 10; 8];
  task2 [12; 2; 10]
