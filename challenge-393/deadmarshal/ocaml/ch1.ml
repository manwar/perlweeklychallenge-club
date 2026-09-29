let pythagoras_multiplied n =
  let rec outer m n count =
    if (m * m) + 1 <= n then outer (m + 1) n (inner m 1 n count) else count
  and inner m k n count =
    if k >= m then count
    else
      let c = (m * m) + (k * k) in
      let add =
        if (m - k) mod 2 = 1 && c <= n && gcd m k = 1 then 2 * (n / c) else 0
      in
      inner m (k + 1) n (count + add)
  and gcd a b = match (a, b) with a, 0 -> a | _, _ -> gcd b (a mod b) in
  outer 2 n 0

let () =
  let l = List.map pythagoras_multiplied [ 20; 7; 1; 15; 30 ] in
  List.iter (fun e -> print_string (string_of_int e ^ " ")) l;
  print_newline ()
