raku -e 'say ($X > 1 ?? [X~] @L xx $X !! @L).grep(* !~~ /^0.+/).grep(* < $Y)'
