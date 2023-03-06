# The Weekly Challenge 206
# Task 2 Array Pairings
use v5.30.0;
use warnings;

sub ap {
    my @arr = sort {$a <=> $b} @_;
    my $sum = 0;
    for my $i (0..($#arr-1)/2) {
        $sum += $arr[2*$i];
    }
    return $sum;
}

use Test::More tests => 2;
ok ap(1, 2, 3, 4) == 4;
ok ap(0, 2, 1, 3) == 2;
