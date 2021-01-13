(* My other solutions use hash tables; let's use a set here instead *)
module StringSet = Set.Make(String)

let substrings s =
  let subs = ref StringSet.empty in
  let len = String.length s in
  for start = 0 to len - 1 do
    for slen = 1 to len - start do
      subs := StringSet.add (String.sub s start slen) !subs
    done
  done;
  !subs

let repeat s n =
  let len = String.length s in
  let newlen = len * n in
  String.init newlen (function i -> String.get s (i mod len))

(* And a non-regular epxression test *)
let ismadeof s sub =
  let reps = (String.length s) / (String.length sub) in
  String.equal (repeat sub reps) s

let task1 a b =
  let subs = StringSet.inter (substrings a) (substrings b) in
  let f sub =
    if ismadeof a sub && ismadeof b sub then
      Printf.printf "%s " sub in
  StringSet.iter f subs;
  print_newline ()

let _ =
  task1 "abcdabcd" "abcdabcdabcdabcd";
  task1 "aaa" "a"
