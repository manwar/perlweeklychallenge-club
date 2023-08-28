#! /usr/bin/raku

use Test;

plan 3;

is-deeply(notminmax([3, 2, 1, 4]), [3, 2], 'example 1');
is-deeply(notminmax([3, 1]), [], 'example 2');
is-deeply(notminmax([2, 1, 3]), [2], 'example 3');

sub notminmax(@a) {
    my $mn = min(@a);
    my $mx = max(@a);
    return Array(@a.grep({$_ != $mn && $_ != $mx}));
}
