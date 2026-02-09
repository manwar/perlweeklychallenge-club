#!/usr/bin/env raku

use Test;

my %examples = (
    38         => [2, 2],
    7          => [0, 7],
    999        => [2, 9],
    1999999999 => [3, 1],
    101010     => [1, 3],
);

for %examples.kv -> $num-str, $expected {
    my $num = $num-str.Int;  # Convert string to Int
    is digital-root-additive-persistence($num), $expected;
}

done-testing;

sub digital-root-additive-persistence(Int $num) {
    return (0, $num) if $num < 10;

    my $sum = $num.comb.sum;
    my ($count, $root) = digital-root-additive-persistence($sum);

    return ($count + 1, $root);
}
