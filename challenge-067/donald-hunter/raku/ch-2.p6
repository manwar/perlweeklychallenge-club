sub phone-combinations(Str $digits) {
        my %keys =
            1 => < _ , @ >,   2 => < a b c >, 3 => < d e f >,
            4 => < g h i >,   5 => < j k l >, 6 => < m n o >,
            7 => < p q r s >, 8 => < t u v >, 9 => < w x y z >,
            '*' => (' ',);

        ('[' ~
         (
             [X~] %keys{ $digits.comb }
         )
         .map({ "\"{$_}\"" })
         .rotor(10, :partial).map({ .join(', ') })
         .join("\n ")
         ~ ']').say
}

phone-combinations '417'
