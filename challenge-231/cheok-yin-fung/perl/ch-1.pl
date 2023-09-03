# The Weekly Challenge 231
# Task 1 Min Max
use v5.30.0;
use warnings;
use List::Util qw/min max/;

sub mm {
    my @ints = @_;
    my @ans = grep { ($_ != max @ints) && ($_ != min @ints) } @ints;
    return -1 if scalar @ans == 0;
    return [@ans];
}

use Test::More tests => 4;
use Test::Deep;
cmp_deeply mm(3, 2, 1, 4), [3,2];
cmp_deeply mm(3, 1), -1;
cmp_deeply mm(2, 1, 3), [2];
cmp_deeply mm(2, 2, 2), -1;
