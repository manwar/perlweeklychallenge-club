#!/usr/bin/perl

use strict;
use warnings;

use Algorithm::Combinatorics qw(permutations);

=head1

Week 134:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-134

Task #1: Pandigital Numbers

    Write a script to generate first 5 Pandigital Numbers in base 10.

=cut

my @digits  = (0,1,2,3,4,5,6,7,8,9);
my @numbers = permutations(\@digits);
my $count   = 0;

foreach (@numbers) {
    my $n = join('', @$_);
    ($n =~ /^0/ && next) || (print "$n\n");
    last if (++$count == 5);
}
