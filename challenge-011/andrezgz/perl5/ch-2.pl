#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-011/
# Challenge #2
# Write a script to create an Indentity Matrix for the given size.
# For example, if the size is 4, then create Identity Matrix 4x4.
# For more information about Indentity Matrix, please read the wiki page.
# https://en.wikipedia.org/wiki/Identity_matrix


use strict;
use warnings;

die "Usage: $0 <matrix-size>" unless $ARGV[0] && $ARGV[0] =~ /\d+/;

my $n = int($ARGV[0]) - 1;

for (0..$n) { print " 0" x $_ . " 1" . " 0" x ($n - $_) . $/; }
