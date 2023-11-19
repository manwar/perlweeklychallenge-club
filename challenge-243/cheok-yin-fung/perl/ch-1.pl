# The Weekly Challenge 243
# Task 1 Reverse Pairs
use v5.30.0;
use warnings;

sub rp {
    my @nums = @_;
    my $ans = 0;
    for my $j (reverse 1..$#nums) {
        for my $i (0..$j-1) {
            $ans++ if $nums[$i] > 2*$nums[$j];
        }
    }
    return $ans;
}

use Test::More tests=>2;
ok rp(1,3,2,3,1) == 2;
ok rp(2,4,3,5,1) == 3;
