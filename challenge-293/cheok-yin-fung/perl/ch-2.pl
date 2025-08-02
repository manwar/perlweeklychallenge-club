# The Weekly Challenge 293
# Task 2 Boomerang
use v5.30;
use warnings;

sub boo {
    my $p0 = $_[0];
    my $p1 = $_[1];
    my $p2 = $_[2];
    return 0 
    if ($p0->[0]-$p1->[0])*($p0->[1]-$p2->[1]) 
            == 
       ($p0->[0]-$p2->[0])*($p0->[1]-$p1->[1]);
    return 1;
}

use Test::More tests=>6;
ok boo([1, 1], [2, 3], [3,2]);
ok !boo([1, 1], [2, 2], [3, 3]);
ok boo([1, 1], [1, 2], [2, 3]);
ok !boo([1, 1], [1, 2], [1, 3]);
ok !boo([1, 1], [2, 1], [3, 1]);
ok boo([0, 0], [2, 3], [4, 5]);
