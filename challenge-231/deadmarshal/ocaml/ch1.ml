let min_max lst =
  let min = List.fold_left min max_int lst and 
      max = List.fold_left max min_int lst
  in
  List.filter (fun n -> n <> min && n <> max) lst

let _ =
  let open Printf in 
  [3;2;1;4]
  |> min_max
  |> List.map string_of_int
  |> String.concat " "
  |> printf "[%s]\n"; 
  [3;1]
  |> min_max
  |> List.map string_of_int
  |> String.concat " "
  |> printf "[%s]\n"; 
  [2;1;3]
  |> min_max
  |> List.map string_of_int
  |> String.concat " "
  |> printf "[%s]\n";

