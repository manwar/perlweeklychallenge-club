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
# For a description of the algorithm see:
# https://abigail.github.io/HTML/Perl-Weekly-Challenge/week-126-1.html 
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
