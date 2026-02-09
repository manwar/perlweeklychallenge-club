#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;
use Test::Deep;

my $examples = {
    38         => [2, 2],
    7          => [0, 7],
    999        => [2, 9],
    1999999999 => [3, 1],
    101010     => [1, 3],
};

is_deeply([ digital_root_additive_persistence($_) ], $examples->{$_})
    for keys %$examples;

done_testing;

sub digital_root_additive_persistence {
    my $num = shift;

    return (0, $num) if $num < 10;

    my $sum = 0;
    $sum += $_ for split //, $num;
    my ($count, $root) = digital_root_additive_persistence($sum);

    return ($count + 1, $root);
}
