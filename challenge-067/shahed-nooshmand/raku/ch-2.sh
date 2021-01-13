raku -e "say [X~] [|('a'..'o').rotor(3), <p q r s>, <t u v>, <w x y z>][35.comb.map(*-2)]"
