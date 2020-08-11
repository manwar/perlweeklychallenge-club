unit sub MAIN(*@A);

@A.kv.map(-> $k,$v {(@A.head($k+1).grep(* < $v) or 0).min}).join(", ").List.say;
