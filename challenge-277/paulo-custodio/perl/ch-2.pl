#!/usr/bin/env perl

use Modern::Perl;
use List::Util 'min', 'uniq';

my @ints = uniq @ARGV;
my $count = 0;
for my $i (0..$#ints-1) {
    for my $j ($i+1..$#ints) {
        $count++ if is_strong_pair($ints[$i], $ints[$j]);
    }
}

say $count;

sub is_strong_pair {
    my($a, $b) = @_;
    return 0 < abs($a-$b) && abs($a-$b) < min($a,$b);
}
