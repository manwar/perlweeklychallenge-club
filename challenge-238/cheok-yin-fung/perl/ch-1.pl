# The Weekly Challenge 238
# Task 1 Running Sum
use v5.30.0;
use warnings;
use List::Util qw/reductions/;

sub rs {
    my @int = @_;
    return [reductions {$a+$b} @int];
}

use Test::More tests=>3;
use Test::Deep;
cmp_deeply rs(1, 2, 3, 4, 5), [1, 3, 6, 10, 15];
cmp_deeply rs(1, 1, 1, 1, 1), [1, 2, 3, 4, 5];
cmp_deeply rs(0, -1, 1, 2), [0, -1, 0, 2];
