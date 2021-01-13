#!/usr/bin/perl
use strict;
use warnings;
use feature 'say';
use Algorithm::Combinatorics qw(combinations);

sub f {
    (sprintf "%b", (pop) ^ pop)=~y/1//
}

my @arr = (2, 3, 4);
#Not recommended when expecting large sums.
say 0+map 1..f(@$_), combinations(\@arr, 2);

=begin
perl .\ch-2.pl
6
=cut