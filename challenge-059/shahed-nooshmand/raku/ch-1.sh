raku -e 'put join " → ", |.grep(* < 3), |.grep(* ≥ 3) given « 1 4 3 2 5 2 »'
