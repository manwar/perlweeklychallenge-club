#!/usr/bin/perl
use warnings;
use strict;

sub common_factors {
    my ($m, $n) = @_;
    ($m, $n) = ($n, $m) if $n < $m;
    my @r;
    for my $i (1 .. $m) {
        push @r, $i if 0 == $m % $i
                    && 0 == $n % $i;
    }
    return \@r
}

use Test::More;

is_deeply common_factors(12, 18), [1, 2, 3, 6], 'Example 1';
is_deeply common_factors(18, 23), [1], 'Example 2';
is_deeply common_factors(123_456_789, 987_654_321), [1, 3, 9], 'large numbers';

done_testing();

