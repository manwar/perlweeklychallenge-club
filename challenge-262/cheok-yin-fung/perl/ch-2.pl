# The Weekly Challenge 262
# Task 2 Count Equal Divisible
use v5.30.0;
use warnings;

sub ced {
    my @ints = $_[0]->@*;
    my $k = $_[1];
    my $count = 0;
    for my $i (0..$#ints-1) {
        for my $j ($i+1..$#ints) {
            $count++ if $ints[$i] == $ints[$j] && ($i*$j % $k == 0);
        }
    }
    return $count;
}

use Test::More tests=>3;
ok ced([3,1,2,2,2,1,3], 2) == 4;
ok ced([1,2,3], 1) == 0;
ok ced([1,2,1], 1) == 1;
