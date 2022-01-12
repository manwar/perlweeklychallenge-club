#!/usr/bin/env perl

use v5.32;
use warnings;

use experimental 'signatures';

my @cache;
my %cache;
sub get_nth_pentagon_number ($n) {
    my $pentagon = $cache[$n];
    $pentagon //= do {
        $cache[$n] = $n * (3 * $n - 1) / 2;
        $cache{ $cache[$n] } = $n;
    }
}

for (my $i = 1; ; $i++) {
    my $ith = get_nth_pentagon_number($i);
    get_nth_pentagon_number(2 * $i - 1);
    get_nth_pentagon_number(2 * $i);
    for (my $j = 1; $j < $i; $j++) {
        my $jth = get_nth_pentagon_number($j);
        if (exists $cache{$ith + $jth} and exists $cache{$ith - $jth}) {
            say "P($i) + P($j) = $ith + $jth = @{[ $ith + $jth ]} = P(", $cache{$ith + $jth}, ")";
            say "P($i) - P($j) = $ith - $jth = @{[ $ith - $jth ]} = P(", $cache{$ith - $jth}, ")";
            exit;
        }
    }
}
