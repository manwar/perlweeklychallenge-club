#! /usr/bin/raku

use Test;

plan 5;

is-deeply(binaryprefix([0, 1, 1, 0, 0, 1, 0, 1, 1, 1]), [True, False, False, False, False, True, True, False, False, False], 'example 1');
is-deeply(binaryprefix([1, 0, 1, 0, 1, 0]), [False, False, True, True, False, False], 'example 2');
is-deeply(binaryprefix([0, 0, 1, 0, 1]), [True, True, False, False, True], 'example 3');
is-deeply(binaryprefix([1, 1, 1, 1, 1]), [False, False, False, True, False], 'example 4');
is-deeply(binaryprefix([1, 0, 1, 1, 0, 1, 0, 0, 1, 1]), [False, False, True, False, False, True, True, True, False, False], 'example 5');

sub binaryprefix(@a) {
    my $c = 0;
    my @out;
    for @a -> $n {
        $c *= 2;
        $c += $n;
        @out.push($c % 5 == 0);
    }
    @out;
}
