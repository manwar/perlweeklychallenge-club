#!/usr/bin/env perl
#
# Write a script to generate Van Eck’s sequence starts with 0
# (https://en.wikipedia.org/wiki/Van_Eck%27s_sequence)
################################################################################

use strict;
use warnings;

my $iterations = shift or die "Usage: $0 <iterations>\n";

# Computed sequence
my @vaneck = (0);

# Map numbers to the last time they appear in sequence
my %lastpos = (0 => 0);

# For every n, compute (push) n+1
foreach my $n (0 .. $iterations-2) {
    my $curn = $vaneck[$n];
    my $m = $lastpos{$curn};
    my $nextn = defined $m ? $n-$m : 0;
    push @vaneck, $nextn;
    $lastpos{$curn} = $n;
}

print "@vaneck\n";
