# The Weekly Challenge 207
# Task 2 H-Index
use v5.30.0;
use warnings;

sub hi {
    my @citations = @_;
    @citations = sort {$b<=>$a} @citations;
    $i = 0;
    while ($i <= $#citations && $citations[$i] >= $i+1) {
        $i++
    }
    return $i;
}

use Test::More tests=>4;
ok hi(10,8,5,4,3) == 4;
ok hi(25,8,5,3,3) == 3;
ok hi(25) == 1;
ok hi(2) == 1;
