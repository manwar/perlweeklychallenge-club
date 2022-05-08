#!/usr/bin/perl
# The Weekly Challenge 163
# Task 1 Sum Bitwise Operator
# Usage: $ ch-1.pl @n
use v5.22.0;
use warnings;
use List::Util qw/sum pairmap first/;

if (defined($ARGV[0])) {
    say sum_bitwise(@ARGV);
}

sub sum_bitwise {
    my @n = @_;
    my $sum = 0;
    for my $i (0..$#n) {
        for my $j (0..$#n) {
            $sum += $n[$i] & $n[$j] if $i != $j && $n[$i] != $n[$j];
        }
    }
    $sum /= 2;
    return $sum;
}

use Test::More tests=>2;
ok sum_bitwise(1,2,3) == 3, "Example 1";
ok sum_bitwise(2,3,4) == 2, "Example 2";

