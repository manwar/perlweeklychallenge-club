#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use Tie::IxHash;

sub missing_members($arr1, $arr2) {
    tie my %seen, 'Tie::IxHash';
    for my $i (0, 1) {
        $seen{$_}[$i] = 1 for @{ ($arr1, $arr2)[$i] };
    }
    my @missing = ([], []);
    for my $e (keys %seen) {
        push @{ $missing[ ! $seen{$e}[0] ] }, $e
            unless 2 == grep $_, @{ $seen{$e} };
    }
    return \@missing
}

use Test2::V0;
plan 2 + 1;

is missing_members([1, 2, 3], [2, 4, 6]), [[1, 3], [4, 6]], 'Example 1';
is missing_members([1, 2, 3, 3], [1, 1, 2, 2]), [[3], []], 'Example 2';
is missing_members([1, 1, 2, 2], [1, 2, 3, 3]), [[], [3]], 'First empty';
