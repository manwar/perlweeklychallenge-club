# The Weekly Challenge 228
# Task 1 Unique Sum
use v5.30.0;
use warnings;
use List::Util qw/sum first/;

sub us {
    my @arr = @_;
    my @brr = (0);
    for my $t (@arr) {
    push @brr, $t if 
           (first {$arr[$_] == $t} 0..$#arr)
        == (first {$arr[$_] == $t} reverse 0..$#arr);
    }
    return sum @brr;
}

use Test::More tests=>3;
ok us(2,1,3,2) == 4;
ok us(1,1,1,1) == 0;
ok us(2,1,3,4) == 10;
