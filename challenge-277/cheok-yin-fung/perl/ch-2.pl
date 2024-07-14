# The Weekly Challenge 277
# Task 2 Strong Pair
use v5.30.0;
use warnings;
use List::Util qw/uniqnum min/;

sub sp {
    my @ints = $_[0]->@*;
    my @nums = uniqnum @ints;
    my $ans = 0;
    for my $i (0..$#nums-1) {
        for my $j ($i+1..$#nums) {
            $ans++ if abs($nums[$i]-$nums[$j]) < min($nums[$i], $nums[$j]);
        }
    }
    return $ans;
}

use Test::More tests=>2;
ok sp([1,2,3,4,5]) == 4;
ok sp([5,7,1,7]) == 1;
