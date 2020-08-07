#!/usr/bin/perl6

multi sub MAIN(
    Str $S  where { $_ ~~ /^ <[0..9 \* \# ]>+ $/ }#= digit string (0 - 9, *, #)
) {
    my %digits = 
        1   => < _ , @ >,
        2   => < a b c >,
        3   => < d e f >,
        4   => < g h i >,
        5   => < j k l >,
        6   => < m n o >,
        7   => < p q r s >,
        8   => < t u v >,
        9   => < w x y z >,
        0   => [ q{} ],
        '*' => [ q{ } ],
        '#' => [ q{} ],
    ;

    say q{[}, ([X] $S.comb.map({ %digits{$_} })).map({ q{"} ~ @_.join({}) ~ q{"} }).join(q{, }), q{]};

}