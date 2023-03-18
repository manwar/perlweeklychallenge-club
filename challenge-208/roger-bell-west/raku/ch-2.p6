#! /usr/bin/raku

use Test;

plan 3;

is-deeply(duplicateandmissing([1, 2, 2, 4]), [2, 3], 'example 1');
is-deeply(duplicateandmissing([1, 2, 3, 4]), [-1], 'example 2');
is-deeply(duplicateandmissing([1, 2, 3, 3]), [3, 4], 'example 3');

sub duplicateandmissing(@a) {
    my $flags = 0;
    my $dup = 0;
    my $mis = 0;
    my $exp = @a[0];
    for @a -> $n {
        if ($n < $exp) {
            $dup = $n;
            $flags +|= 1;
        } elsif ($n > $exp) {
            $mis = $exp;
            $flags +|= 2;
        }
        if ($flags == 3) {
            return [$dup, $mis];
        }
        $exp = $n + 1;
    }
    if ($flags == 1) {
        return [$dup, $exp];
    }
    return [-1];
}
