# The Weekly Challenge 281
# Task 1 Check Color
use v5.30;
use warnings;

sub cc {
    my $coord = $_[0];
    my $pos = [ord(substr($coord,0,1))-ord("a"), substr($coord,1,2)-1];
    return ($pos->[0]-$pos->[1]) % 2;
}

use Test::More tests=>3;
ok cc("d3");
ok !cc("g5");
ok cc("e6");
