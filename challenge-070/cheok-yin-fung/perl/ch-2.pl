#!/usr/bin/perl
# Perl Weekly Challenge #070 Task 2 Gray Code Sequence
# Usage: ch-2.pl [order of Gray code wanted to generate]

use strict;
use warnings;

my @a = (0,1);
my $N = 3;
if ($ARGV[0]) {$N = $ARGV[0];}

sub printa {
    print join " ", @a;
    print "\n";
}

for my $i (2..$N) {
    push @a, reverse (map {$_ + 2**($i-1)} @a);
}

printa;
