#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);

# TASK #2 › Magical Matrix
#
# Write code to produce a 3x3 magic square

my @m;
my $m = 3;
my $r = 0;
my $c = 1;

# fill in the magic square using the Siamese method
for my $i (1..9) {
    $m[$r][$c] = $i;
    my $r1 = ($r - 1) % $m;
    my $c1 = ($c + 1) % $m;
    if (defined $m[$r1][$c1]) {
        $r = ($r + 1) % $m;
    } else {
        $r = $r1;
        $c = $c1;
    }
}

# print the result
for my $r (0..$m-1) {
    for my $c (0..$m-1) {
        print "$m[$r][$c] ";
    }
    print "\n";
}
