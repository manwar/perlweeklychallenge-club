#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl
#=============================================================================
# Copyright (c) 2021, Bob Lied
#=============================================================================
# Perl Weekly Challenge 137, Task 1: Long Year
#
# Write a script to find all the years between 1900 and 2100 which is a Long
# Year.  A year is Long if it has 53 weeks.
# 
#=============================================================================

use strict;
use warnings;
use v5.32;

use experimental qw/ signatures /;
no warnings "experimental::signatures";

use DateTime;

my @longYearList;

for my $year ( 1900 .. 2100 )
{
    my $dt = DateTime->new(year => $year, month => 12, day => 31);
    my ($year, $weeknum) = $dt->week();

    push @longYearList, $year if $weeknum == 53;
}

# Output in comma-separated groups of five.
my @row;
while ( @longYearList )
{
    push @row, join(", ", splice(@longYearList, 0, 5) );
}
say join(",\n", @row);
