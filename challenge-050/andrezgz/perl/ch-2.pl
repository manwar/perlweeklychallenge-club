#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-050/
# Task #2
#
# Noble Integer
# You are given a list, @L, of three or more random integers between 1 and 50.
# A Noble Integer is an integer N in @L, such that there are exactly N integers
# greater than N in @L. Output any Noble Integer found in @L, or an empty list
# if none were found.
#
# An interesting question is whether or not there can be multiple Noble Integers in a list.
#
# For example,
#
# Suppose we have list of 4 integers [2, 6, 1, 3].
#
# Here we have 2 in the above list, known as Noble Integer, since there are
# exactly 2 integers in the list i.e.3 and 6, which are greater than 2.
#
# Therefore the script would print 2.

use strict;
use warnings;

my $elements = shift || 3;

my @L = sort {$a <=> $b} map { int(rand(49)) + 1 } 1..$elements;
print 'List: ' . join ',', @L;

my @nobles;
for my $n (@L) {
    my $greater = grep { $_ > $n} @L;
    push @nobles, $n if $greater == $n;
}
print "\nNoble Integers: ", join ',', @nobles;

__END__

./ch-2.pl
List: 2,14,43
Noble Integers: 2

./ch-2.pl 4
List: 2,2,8,9
Noble Integers: 2,2

./ch-2.pl 6
List: 5,10,18,24,42,42
Noble Integers: 5

./ch-2.pl 6
List: 20,23,29,34,40,44
Noble Integers:

./ch-2.pl 15
List: 1,3,12,18,21,21,23,27,28,34,34,35,36,39,48
Noble Integers: 12
