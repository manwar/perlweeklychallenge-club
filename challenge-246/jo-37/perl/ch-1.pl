#!/usr/bin/perl

use v5.11;
use warnings;


### Input and Output

srand time;
say for sixoutoffortynine();


### Implementation

sub sixoutoffortynine {
	my @pool = (1..49);
    my @winning;
    push @winning, splice @pool, rand @pool, 1 for 1 .. 6;
    sort {$a <=> $b} @winning;
}
