# The Weekly Challenge 195
# Task 1 Special Integers
use v5.30.0;
use warnings;
use List::Util qw/uniqint/;

sub si {
    my $n = $_[0];
    my $ans = 0;
    for my $i (1..$n) {
        $ans++ if length $i == scalar uniqint split "", $i;
    }
    return $ans;
}

use Test::More tests=>2;
ok si(15) == 14;
ok si(35) == 32;

