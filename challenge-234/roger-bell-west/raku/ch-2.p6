#! /usr/bin/raku

use Test;

plan 3;

is(unequaltriplets([4, 4, 2, 4, 3]), 3, 'example 1');
is(unequaltriplets([1, 1, 1, 1, 1]), 0, 'example 2');
is(unequaltriplets([4, 7, 1, 10, 7, 4, 1, 1]), 28, 'example 3');

sub unequaltriplets(@utl) {
    my %utc = @utl.Bag;
    my @kl = %utc.keys;
    if (@kl.elems < 3) {
        return 0;
    }
    my $out = 0;
    for @kl.combinations(3) -> @ix {
        $out += %utc{@ix[0]} * %utc{@ix[1]} * %utc{@ix[2]};
    }
    return $out;
}
