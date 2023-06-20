let rec last_member = function
  | []  -> 0
  | [x] -> 1
  | f :: s :: t ->
    if f != s then
      last_member (s-f :: t)
    else
      last_member t
        
let _ =
  [2;7;4;1;8;1] |> last_member |> Printf.printf "%d\n";
  [1]           |> last_member |> Printf.printf "%d\n";
  [1;1]         |> last_member |> Printf.printf "%d\n"
  
