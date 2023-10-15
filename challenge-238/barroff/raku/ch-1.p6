#!/usr/bin/env raku

use v6.d;

sub running-sum(@ints, Int:D $rs = 0 --> Positional:D) {
    given @ints.elems {
        when 1 { return [@ints[0] + $rs] }
        default { my $new_rs = @ints[0] + $rs;
                  return [$new_rs, |running-sum(@ints[1..*], $new_rs)]
        }
    }
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is running-sum([1, 2, 3, 4, 5]), [1, 3, 6, 10, 15],
        'works for (1, 2, 3, 4, 5)';
    is running-sum([1, 1, 1, 1, 1]), [1, 2, 3, 4, 5],
        'works for (1, 1, 1, 1, 1)';
    is running-sum([0, -1, 1, 2]), [0, -1, 0, 2],
        'works for (0, -1, 1, 2)';
}

#| Take user provided list like 1 1 2 2 2 3
multi sub MAIN(*@ints where @ints.elems ≥ 1) {
    say running-sum(@ints);
}
