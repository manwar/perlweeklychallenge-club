#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-023/
# Task #1
# Create a script that prints nth order forward difference series.
# You should be a able to pass the list of numbers and order number as command line parameters.
# Let me show you with an example.
# Suppose we have list (X) of numbers: 5, 9, 2, 8, 1, 6 and we would like to create 1st order forward difference series (Y).
# So using the formula Y(i) = X(i+1) - X(i), we get the following numbers: (9-5), (2-9), (8-2), (1-8), (6-1).
# In short, the final series would be: 4, -7, 6, -7, 5. If you noticed, it has one less number than the original series.
# Similary you can carry on 2nd order forward difference series like: (-7-4), (6+7), (-7-6), (5+7) => -11, 13, -13, 12.

use strict;
use warnings;

die "Usage: $0 <comma-separated number list> [<order number>]" if @ARGV != 2;

my @list = split /,/,shift;
die 'List should have at leat 2 numbers' if @list < 2;

my $order = shift || 1;
die 'Max order is '.$#list if $order > $#list;

for (1 .. $order) {
    @list = map {$list[$_] - $list[$_-1]} (1 .. $#list);
    print join(',', @list).$/;
}
