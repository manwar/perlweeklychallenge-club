#!/usr/bin/env raku

use v6.d;

sub separate-digits(@ints --> Array) {
    my Str @stringified-ints = map({ Str($_) }, @ints);
    my Str $connected-ints = join('', @stringified-ints);
    return Array(map({ Int($_) }, $connected-ints.comb));
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is separate-digits((1, 34, 5, 6)), [1, 3, 4, 5, 6],
        'works for (1, 34, 5, 6)';
    is separate-digits((1, 24, 51, 60)), [1, 2, 4, 5, 1, 6, 0],
        'works for (1, 24, 51, 60)';
}


#| Take user provided list like 1 24 51 60
multi sub MAIN(*@ints where @ints.elems ≥ 1) {
    say separate-digits(@ints);
}
