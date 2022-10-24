#! /usr/bin/perl6

use Test;

plan 4;

is-deeply(magicaltriplets([1, 2, 3, 2]),
          [3, 2, 2],
          'example 1');

is-deeply(magicaltriplets([1, 3, 2]),
          [],
          'example 2');

is-deeply(magicaltriplets([1, 1, 2, 3]),
          [],
          'example 3');

is-deeply(magicaltriplets([2, 4, 3]),
          [4, 3, 2],
          'example 4');

sub magicaltriplets(@a) {
    my @out;
    my $mv = 0;
    for @a.combinations(3) -> @b {
        if (@b[0] + @b[1] > @b[2] &&
            @b[1] + @b[2] > @b[0] &&
            @b[0] + @b[2] > @b[1]) {
            my $v = @b.sum;
            if ($v > $mv) {
                $mv = $v;
                @out = @b;
            }
        }
    }
    return Array(@out.sort.reverse);
}
