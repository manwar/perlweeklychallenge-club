#!/usr/bin/perl
use warnings;
use strict;

my @list = (10, 4, 1, 8, 12, 3);
my @indices = (0, 2, 5);

my @sorted = @list;
@sorted[@indices] = sort { $a <=> $b } @sorted[@indices];

my @expected = (1, 4, 3, 8, 12, 10);

"@sorted" eq "@expected"
    or die "Got:      @sorted\nExpected: @expected\n";
