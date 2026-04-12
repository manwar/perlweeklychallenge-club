#!/usr/bin/perl
use strict;
use warnings;

my %rows = (
    1 => 'One', 2 => 'Two', 3 => 'Three', 4 => 'Four', 5 => 'Five', 6 => 'Six',
    7 => 'Seven', 8 => 'Eight', 9 => 'Nine', 10 => 'Ten', 11 => 'Eleven',
    12 => 'Twelve', 13 => 'Thirteen', 14 => 'Fourteen', 15 => 'Fifteen',
);

my @nums = 1..15;
my %seen;

while (<DATA>) {
    my ($no) = split /,/;
    $seen{$no} = 1;
}

# Build a new array of numbers that are missing
my @missing = grep { !$seen{$_} } @nums;

# There should be only one missing number
my $missing = $missing[0];

print "Missing: $missing, Line $rows{$missing}\n"; # Output: Missing: 12, Line Twelve

__DATA__
11, Line Eleven
1, Line One
9, Line Nine
13, Line Thirteen
2, Line Two
6, Line Six
8, Line Eight
10, Line Ten
7, Line Seven
4, Line Four
14, Line Fourteen
3, Line Three
15, Line Fifteen
5, Line Five
