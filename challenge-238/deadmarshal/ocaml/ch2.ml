let rec digits (d:int) =
  if d = 0 then [] else digits (d / 10) @ [d mod 10]

let rec helper (acc:int) (n:int) =
  let rec product prod lst = 
    match lst with 
    | [] -> prod
    | hd :: tl ->
       product (prod * hd) tl
  in
  if n < 10 then
    acc
  else
  helper (succ acc) (product 1 (digits n))

let persistence_sort (lst:int list) =
  List.sort (fun a b ->
      let ha = helper 0 a and hb = helper 0 b in
      if ha <> hb then
        compare ha hb
      else
        compare a b) lst

let _ =
  let open Printf in 
  persistence_sort [15;99;1;34]
  |> List.map string_of_int
  |> String.concat " "
  |> printf "[%s]\n";
  persistence_sort [50;25;33;22]
  |> List.map string_of_int
  |> String.concat " "
  |> printf "[%s]\n";
    
