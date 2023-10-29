# The Weekly Challenge 240
# Task 2 Build Array
use v5.30.0;
use warnings;

sub ba {
    my @int = @_;
    my @new = map {$int[$int[$_]]} (0..$#int);
    return [@new];
}

use Test::More tests=>2;
use Test::Deep;

cmp_deeply ba(0, 2, 1, 5, 3, 4), [0, 1, 2, 4, 5, 3];
cmp_deeply ba(5, 0, 1, 2, 3, 4), [4, 5, 0, 1, 2, 3];
