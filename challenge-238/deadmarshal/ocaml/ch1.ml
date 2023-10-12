let running_sum lst =
  let rec aux s acc lst =
    match lst with
    | [] -> acc
    | hd :: tl ->
       let temp = s + hd in
       aux temp (temp :: acc) tl 
  in 
  List.rev (aux 0 [] lst)

let _ =
  let open Printf in
  [1;2;3;4;5]
  |> running_sum
  |> List.map string_of_int
  |> String.concat " "
  |> printf "[%s]\n";
  [1;1;1;1;1]
  |> running_sum
  |> List.map string_of_int
  |> String.concat " "
  |> printf "[%s]\n";
  [0;-1;1;2]
  |> running_sum
  |> List.map string_of_int
  |> String.concat " "
  |> printf "[%s]\n";

