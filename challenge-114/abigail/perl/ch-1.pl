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

#
# See https://abigail.github.io/HTML/Perl-Weekly-Challenge/week-114-1.html
# for a description of the algorithm.
#

while (<>) {
    chomp;
    if (/^9+$/) {
        say $_ + 2;
        next;
    }

    if (length ($_) == 1) {
        say $_ + 1;
        next;
    }

    #
    # Split the number into parts 2 equal parts, with a middle part
    # of at most one digit.
    #
    my $part1 = substr $_, 0, int length ($_) / 2;
    my $part2 = substr $_,    int length ($_) / 2,  length ($_) % 2;
    my $part3 = substr $_,    int length ($_) / 2 + length ($_) % 2;

    if (reverse ($part1) <= $part3) {
        $part1 = "$part1$part2" + 1;
        $part2 = chop $part1 if length $part2;
    }
    say $part1, $part2, scalar reverse ($part1);
}
