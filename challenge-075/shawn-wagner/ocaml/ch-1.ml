let sum = List.fold_left (+) 0

let rec solve coins s =
  if s = 0 then
    [[]]
  else begin
    let solutions = ref [] in
    List.iter (function coin ->
        let f solution = if (sum solution) + coin = s then
            Some (coin :: solution)
          else
            None in
        if s - coin >= 0 then
          solutions :=
            List.append (List.filter_map f (solve coins (s - coin)))
              !solutions) coins;
    !solutions
  end

let task1 coins s =
  let solutions= solve coins s in
  let solutions = List.map (List.sort Int.compare) solutions in
  let solutions = List.sort_uniq compare solutions in
  Printf.printf "There are %d possible ways to make sum %d\n" (List.length solutions) s

let _ =
  task1 [1;2;4] 6
    
