#!/usr/bin/env raku

use v6.d;

sub unequal-triplets(@ints --> Int:D) {
    my $ints-bag = Bag(@ints);
    return 0 if $ints-bag.elems < 3;
    [+] map({ [*] $ints-bag{$_} }, $ints-bag.keys.combinations: 3);
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is unequal-triplets([4, 4, 2, 4, 3]), 3, 'works for (4, 4, 2, 4, 3)';
    is unequal-triplets([1, 1, 1, 1, 1]), 0, 'works for (1, 1, 1, 1, 1)';
    is unequal-triplets([4, 7, 1, 10, 7, 4, 1, 1]), 28,
        'works for (4, 7, 1, 10, 7, 4, 1, 1)';
}

#| Take user provided list like 1 1 2 2 2 3
multi sub MAIN(*@ints where @ints.elems ≥ 1) {
    say unequal-triplets(@ints);
}
