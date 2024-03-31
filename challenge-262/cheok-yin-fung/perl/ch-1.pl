# The Weekly Challenge 262
# Task 1 Max Positive Negative
use v5.30.0;
use warnings;

sub mpn {
    my @ints = @_;
    my $p = grep {$_ > 0} @ints;
    my $n = grep {$_ < 0} @ints;
    return $p > $n ? $p : $n;
}

use Test::More tests=>4;
ok mpn(-3, 1, 2, -1, 3, -2, 4) == 4;
ok mpn(-1,-2,-3, 1) == 3;
ok mpn(1,2) == 2;
ok mpn(0,0,0) == 0;
