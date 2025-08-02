#!/usr/bin/env raku

use v6.d;

sub three-digits-even(@ints --> Seq) {
    my $tde = ().SetHash;

    sub check-comb(@ints) {
        if (@ints[*-1] mod 2) == 0 and @ints[0] ≠ 0 {
            $tde.set(@ints.join);
        }
        return Nil;
    }

    sub check-perms(@ints) {
        my @prms = @ints.permutations;
        map({ check-comb($_) }, @prms);
        return Nil;
    }

    map({ check-perms($_) }, @ints.combinations: 3);

    return $tde.keys;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is sort(three-digits-even([2, 1, 3, 0])),
        (102, 120, 130, 132, 210, 230, 302, 310, 312, 320),
        'works for "[2, 1, 3, 0]"';
    is sort(three-digits-even([2, 2, 8, 8, 2])),
        (222, 228, 282, 288, 822, 828, 882),
        'works for "[2, 2, 8, 8, 2]"';
}

#| Take user provided numbers like 2 2 8 8 2
multi sub MAIN(*@ints) {
    say three-digits-even(@ints);
}
