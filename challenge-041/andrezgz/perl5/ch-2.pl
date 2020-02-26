#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-041/
# Task #2
# Write a script to display first 20 Leonardo Numbers.
# Please checkout wiki page for more information.
# https://en.wikipedia.org/wiki/Leonardo_number
# For example:
#
# L(0) = 1
# L(1) = 1
# L(2) = L(0) + L(1) + 1 = 3
# L(3) = L(1) + L(2) + 1 = 5
# and so on.

use strict;
use warnings;
use Memoize;

memoize('leo');

my $upto = shift || 20;
print leo($_).' ' for (0 .. --$upto);

sub leo {
    my $n = shift;
    return $n <= 1 ? 1 : leo($n-1) + leo($n-2) + 1;
}

__END__

./ch-2.pl 20
1 1 3 5 9 15 25 41 67 109 177 287 465 753 1219 1973 3193 5167 8361 13529
