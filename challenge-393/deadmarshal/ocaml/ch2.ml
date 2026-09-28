let prime_step s =
  let rec is_prime n = if n <= 1 then false else not (has_divisor n 2)
  and has_divisor n i =
    if i * i > n then false
    else if n mod i = 0 then true
    else has_divisor n (i + 1)
  in
  let rec step sum d =
    if is_prime (sum - d) || is_prime (sum + d) then d else step sum (d + 1)
  in
  let sum =
    List.fold_left ( + ) 0
      (List.map Char.code (List.init (String.length s) (String.get s)))
  in
  step sum 0

let _ =
  let l =
    List.map prime_step [ "hello"; "football"; "a"; "challenge"; "perl" ]
  in
  List.iter (fun e -> print_string (string_of_int e ^ " ")) l;
  print_newline ()
