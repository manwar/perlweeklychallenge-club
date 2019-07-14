#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

my %shares;
my $pie = 100.0;
for my $guest (1 .. 100)  {
    my $share = $pie * ($guest * 0.01);
    $shares{$guest} = $share;
    $pie -= $share;
}

my $top = (reverse sort { $shares{$a} <=> $shares{$b} } keys %shares)[0];

say "Guest $top gets ", sprintf("%0.2f", $shares{$top}), '% of the pie.';
