#! /usr/bin/raku

use Test;

plan 2;

is-deeply(twoofthree([[1, 1, 2, 4], [2, 4], [4]]), [2, 4], 'example 1');
is-deeply(twoofthree([[4, 1], [2, 4], [1, 2]]), [1, 2, 4], 'example 2');

sub twoofthree(@a) {
    my %ct;
    for @a -> @iv {
        Set.new(@iv).keys.map({%ct{$_}++});
    }
    my @out;
    for %ct.kv -> $k, $v {
        if ($v >= 2) {
            push @out, $k+0;
        }
    }
    return Array(@out.sort);
}
