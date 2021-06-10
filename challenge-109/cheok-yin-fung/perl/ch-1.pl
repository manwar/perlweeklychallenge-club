#!/usr/bin/perl
# The Weekly Challenge - 109 
# Task 1 Chowla Numbers
use strict;
use warnings;
my $F = $ARGV[0] || 20;
my @chowla_seq = (0,0,0);
for my $n (4..$F) {
    my $s = 0;
    for my $k (2..$n-1) {
        $s += $k unless $n % $k;
    }
    push @chowla_seq, $s;
}
print join ", ", @chowla_seq;
print "\n";
