# The Weekly Challenge 250
# Task 1 Smallest Index
use v5.30.0;
use warnings;

sub si {
    my @arr = @_;
    for my $k (0..$#arr) {
        return $k if $k == $arr[$k] % 10;
    }
    return -1;
}

use Test::More tests=>3;
ok si(0, 1, 2) == 0;
ok si(4, 3, 2, 1) == 2;
ok si(1, 2, 3, 4, 5, 6, 7, 8, 9, 0) == -1;
