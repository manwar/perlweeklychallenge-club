#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-152
#

#
# Run as: perl ch-1.pl < input-file
#
# We expect the entire triangle to be given as whitespace separated
# numbers, all on one line. Give it's a triangle, we don't need to
# know where the next row starts.
# Each new line is considered a different triangle.
#

#
# At first, I thought "path" was used in the traditional sense:
# we were to view the triangle as a graph, each node having two
# edges downwards to the nearest nodes on the next row.
# But it looks like we can just take any node on each row, and 
# they will all connect. Which makes the exercise trivial: we
# just sum the minimum value from each row.
#

use List::Util qw [min];

while (<>) {
    my ($n, $min_sum, @numbers) = (1, 0, split);
    $min_sum += min splice @numbers, 0, $n ++ while @numbers;
    say $min_sum;
}
