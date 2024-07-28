#!/usr/bin/env raku

use v6.d;

sub sort-letters(@letters, @weights where @letters.elems == @weights.elems --> Str) {
    my %ldict = @weights Z=> @letters;
    %ldict{1..@weights.elems}.join;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is sort-letters(('R', 'E', 'P', 'L'), (3, 2, 1, 4)), 'PERL',
        'works for ("R", "E", "P", "L") and (3, 2, 1, 4)';
    is sort-letters(('A', 'U', 'R', 'K'), (2, 4, 1, 3)), 'RAKU',
        'works for ("A", "U", "R", "K") and (2, 4, 1, 3)';
    is sort-letters(('O', 'H', 'Y', 'N', 'P', 'T'), (5, 4, 2, 6, 1, 3)), 'PYTHON',
        'works for ("O", "H", "Y", "N", "P", "T") and (5, 4, 2, 6, 1, 3)';
}

#| Take user provided letters and weights like R E P L 3 2 1 4
multi sub MAIN(Str @letters, Int @weights) {
    say sort-letters(@letters, @weights);
}
