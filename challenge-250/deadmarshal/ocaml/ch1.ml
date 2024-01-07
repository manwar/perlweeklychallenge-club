let smallest_index lst =
  let rec range l h =
    if l = h then [] else l :: range (succ l) h
  in
  let rec aux = function
    | [] -> -1
    | (i,e) :: tl ->
      if i mod 10 == e then i else aux tl
  in
  List.combine (range 0 (List.length lst)) lst |> aux
  
let _ =
  let open Printf in
  [0;1;2]               |> smallest_index |> printf "%d\n";
  [4;3;2;1]             |> smallest_index |> printf "%d\n";
  [1;2;3;4;5;6;7;8;9;0] |> smallest_index |> printf "%d\n";
  
