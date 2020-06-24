#!/usr/bin/perl

use strict;
use warnings;

my $N = $ARGV[0];
print sprintf("%d = %s\n", $N, join(", ", @{get_power_integers($N)}));

sub get_power_integers {
    my ($n) = @_;

    my $power_integers = [];

    my $i = 2;
    while ( $i <= sqrt($n) ) {
        my $j = 2;
        while ( $j <= $n ) {
            if (($i ** $j) == $n) {
                push @$power_integers, sprintf("%d ^ %d", $i, $j);
            }
            $j++;
        }
        $i++;
    }

    return $power_integers if scalar(@$power_integers);
    return 0;
}
