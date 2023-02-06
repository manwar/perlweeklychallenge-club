# The Weekly Challenge 202
# Task 1 Consecutive Odds
use v5.30.0;
use warnings;

sub co {
    my @array = @_;
    $_ = join "", map {$_ % 2} @array;
    return /111/ ? 1 : 0;
}

use Test::More tests => 4;
ok co(1,5,3,6) == 1;
ok co(2,6,3,5) == 0;
ok co(1,2,3,4) == 0;
ok co(2,3,5,7) == 1;
