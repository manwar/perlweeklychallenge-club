#!/usr/bin/perl

use strict;
use warnings;

my $len = int(rand(7)) + 3;
my @L   = ();

while ($len) {
    my $i = int(rand(50)) + 1;
    # assuming we want a unique list
    unless (grep { $_ == $i } @L) {
        push @L, $i;
        $len--;
    }
}

print '[' . join(', ', @L) . "]\n\n";

foreach my $i (sort { $a <=> $b } @L) {
    if (scalar(grep {$_ > $i} @L) == $i) {
        print "Noble Integer: $i\n";
        
        # there cannot be multiple in a list because
        # the next greater noble integer nullifies the
        # the previous smaller noble integer
        last;
    }
}
