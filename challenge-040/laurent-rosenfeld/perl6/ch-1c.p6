use v6;

my @a = < I L O V E Y O U >,
        < 244 42 0 1233 222 0 11 90 >,
        < ! ???? £ $ %% ^ & * >,
        < a b c d e f g f >;

my @b = [Z] @a;  # performs transposition
say join "\t", map {$_ // "" }, @$_ for @b;
