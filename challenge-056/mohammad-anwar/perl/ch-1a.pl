#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use Test::Deep;

my $unit_tests = {
    2 => {
        in  => [10, 8, 7, 6, 1],
        out => [ " 0, 1 => (10 -  8) => 2",
                 " 1, 3 => ( 8 -  6) => 2" ]
    },
    3 => {
        in  => [20, 15, 14, 10, 7, 6, 4, 1],
        out => [ " 3, 4 => (10 -  7) => 3",
                 " 4, 6 => ( 7 -  4) => 3",
                 " 6, 7 => ( 4 -  1) => 3"]
    },
    4 => {
        in  => [50, 40, 30, 20, 10],
        out => [ ]
    },
};

foreach my $k (sort keys %$unit_tests) {
    my $in  = $unit_tests->{$k}->{in};
    my $out = $unit_tests->{$k}->{out};

    is_deeply(find_match($k, @$in), $out, "testing with k=$k");
}

done_testing;

sub find_match {
    my ($K, @L) = @_;

    my $S = scalar(@L);
    my $matched = [];
    foreach my $i (0 .. --$S) {
        foreach my $j ($i+1 .. $S) {
            my $k = $L[$i] - $L[$j];
            if ($k == $K) {
                push @$matched, sprintf("%2s,%2s => (%2s - %2s) => %d", $i, $j, $L[$i], $L[$j], $k);
            }
        }
    }

    return $matched;
}
