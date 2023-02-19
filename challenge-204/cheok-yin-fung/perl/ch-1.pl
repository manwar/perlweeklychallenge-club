# The Weekly Challenge 204
# Task 1 Monotonic Array
use v5.30.0;
use warnings;
use List::Util qw/all/;
use List::MoreUtils qw/slide/;

sub ma {
    my @arr = @_;
    return    (all {$_ >= 0} slide {$a-$b} @arr)
           || (all {$_ <= 0} slide {$a-$b} @arr);
}

use Test::More tests=>3;
ok ma(1,2,2,3) == 1;
ok ma(1,3,2) == 0;
ok ma(6,5,5,4) == 1;
