#!/usr/bin/env perl
use v5.40;

my @output;

for (my $i = 0; $i < @ARGV; $i += 2) {
    my $cnt = $ARGV[$i];
    my $val = $ARGV[$i+1];
    push @output, ($val) x $cnt;
}

printf "(%s)\n", join ", ", @output;
