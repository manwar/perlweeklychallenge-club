#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-003/
# Challenge #2
# Create a script that generates Pascal Triangle. Accept number of rows from the command line.
# The Pascal Triangle should have at least 3 rows.
# For more information about Pascal Triangle, check this wikipedia page. https://en.wikipedia.org/wiki/Pascal%27s_triangle

use strict;
use warnings;

my $rows = $ARGV[0] || 0;

if ($rows < 3) {
    print "The Pascal Triangle should have at least 3 rows\n";
    $rows = 3;
}

my @row = (1);

while ($rows) {
    print join(' ',@row) .$/;
    $rows--;
    @row = map {$row[$_] += $row[$_+1]} 0..@row-2;
    unshift @row, 1;
    push @row, 1;
}
