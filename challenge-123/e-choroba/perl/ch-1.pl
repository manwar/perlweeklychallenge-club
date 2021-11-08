#!/usr/bin/perl
use warnings;
use strict;

use List::Util qw{ min };

my @multipliers = (2, 3, 5);
sub ugly_number {
    my ($n) = @_;
    my @ugly = (undef, 1);
    my @indices = (1, 1, 1);
    for (1 .. $n) {
        my @next = map $multipliers[$_] * $ugly[ $indices[$_] ], 0 .. $#indices;
        push @ugly, min(@next);
        for my $i (0 .. $#indices) {
            ++$indices[$i] if $ugly[-1] == $next[$i];
        }
    }
    return $ugly[$n]
}

use Test::More tests => 5;

is ugly_number(7),   8, 'Example 1';
is ugly_number(10), 12, 'Example 2';

is ugly_number(150), 5832, 'Large';
is ugly_number(1000), 51200000, 'Larger';
is ugly_number(13_282), 18_432_000_000_000_000_000, 'Largest';

