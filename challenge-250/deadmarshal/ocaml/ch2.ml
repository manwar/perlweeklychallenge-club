let explode s =
  let rec exp i l =
    if i < 0 then l else exp (i - 1) (s.[i] :: l) in
  exp (String.length s - 1) []

let alphanumeric_string_value xs =
  let is_digit = function '0'..'9' -> true | _ -> false in
  let rec transform = function
  | [] -> []
  | hd :: tl ->
     if (List.for_all is_digit (explode hd)) then
       (int_of_string hd) :: transform tl
     else String.length hd :: transform tl
  in
  List.fold_left max Int.min_int (transform xs)

let _ =
  let open Printf in
  ["perl";"2";"000";"python";"r4ku"]
  |> alphanumeric_string_value
  |> printf "%d\n";
  ["001";"1";"000";"0001"]
  |> alphanumeric_string_value
  |> printf "%d\n"

