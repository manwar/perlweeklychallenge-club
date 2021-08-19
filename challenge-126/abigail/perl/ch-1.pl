#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-1.pl < input-file
#
# We will be reading from standard input, assuming an input number
# on each line of the input.
#

#
# To get the nth number which doesn't contain a 1, you would
# convert n to base 9, then replace each non-zero digit d, with d + 1.
#
# This process is reversable, assuming a number doesn't contain a 1:
# Replace each non-zero digit d with d + 1, then convert the resulting
# base-9 number back to base 10.
#
# The result will give the number of numbers up to the input number 
# which do not contain a 1.
#
# For input numbers n containing a 1, consider the number p, such that
# p is the largest integer smaller than n, which doesn't contain a 1.
# Since all numbers between p and n contain a 1, there are as many numbers
# up to p not containing a 1, as there are up to n.
#
# To get p, find the first 1 in n, replace this 1 by a 0, and replace each
# subsequent digit by a 9. If n doesn't contain a 1, p == n.
#
# We can collapse all three processes (finding p, subtracting 1 from
# non-zero digits, and converting from base-9 to base-10) into a single
# pass over the digits of $n:
#

while (my $n = <>) {
    chomp $n;

    my $result   = 0;
    my $seen_one = 0;
    foreach my $digit (split // => $n) {
        $result *= 9;
        if    ($seen_one)   {$result += 8}
        elsif ($digit == 1) {$seen_one = 1}
        elsif ($digit)      {$result += $digit - 1}
    }
    say $result;
}
