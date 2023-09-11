#!/usr/bin/env raku

use v6.d;

sub frequency-sort(@ints --> Seq) {
    my $ints-bag = Bag(@ints);
    @ints.sort: {
        $ints-bag{$^a} == $ints-bag{$^b}
        ?? $^b cmp $^a
        !! $ints-bag{$^a} cmp $ints-bag{$^b}
    };
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is frequency-sort([1,1,2,2,2,3]), ([3,1,1,2,2,2]), 'works for (1,1,2,2,2,3)';
    is frequency-sort([2,3,1,3,2]), ([1,3,3,2,2]), 'works for (2,3,1,3,2)';
    is frequency-sort([-1,1,-6,4,5,-6,1,4,1]), ([5,-1,4,4,-6,-6,1,1,1]),
        'works for (-1,1,-6,4,5,-6,1,4,1)';
}

#| Take user provided list like 1 1 2 2 2 3
multi sub MAIN(*@ints where @ints.elems ≥ 1) {
    say frequency-sort(@ints);
}
