#!/usr/bin/perl

# https://theweeklychallenge.org/blog/perl-weekly-challenge-145/
# TASK #1 > Dot Product
#
# You are given 2 arrays of same size, @a and @b.
#
# Write a script to implement Dot Product.
#
# Example:
# @a = (1, 2, 3);
# @b = (4, 5, 6);
#
# $dot_product = (1 * 4) + (2 * 5) + (3 * 6) => 4 + 10 + 18 => 32

use strict;
use warnings;
use feature 'say';

my @a = split /,/, shift || die "First array of numbers is missing e.g. 1,2,3\n";
my @b = split /,/, shift || die "Second array of numbers is missing e.g. 4,5,6\n";

die "Arrays should only contain numbers\n" if grep { /[^\d]/ } (@a,@b);
die "Arrays should have the same size\n"   if @a != @b;

my $dot_product = 0;
$dot_product += shift(@a) * shift(@b) while @a;
say $dot_product;

__END__

$ ./challenge-145/andrezgz/perl/ch-1.pl 1,2,3 4,5,6
32
