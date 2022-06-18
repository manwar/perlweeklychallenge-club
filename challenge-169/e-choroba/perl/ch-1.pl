#!/usr/bin/perl
use warnings;
use strict;

use Math::Prime::Util qw{ factor };

sub brilliant_numbers {
    my ($tally) = @_;
    my @brilliant_numbers;
    my $n = 1;
    while (@brilliant_numbers < $tally) {
        my @f = factor(++$n);
        push @brilliant_numbers, $n
            if 2 == @f
            && length($f[0]) == length($f[1]);
    }
    return \@brilliant_numbers
}

use Test::More tests => 1;

is_deeply brilliant_numbers(20),
    [4, 6, 9, 10, 14, 15, 21, 25, 35, 49, 121,
     143, 169, 187, 209, 221, 247, 253, 289, 299];
