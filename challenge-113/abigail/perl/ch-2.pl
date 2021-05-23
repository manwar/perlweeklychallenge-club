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
# Run as: perl ch-2.pl < input-file
#

#
# I have two major issues with the "binary tree" part of the problem.
# 
# First, and we have seen this problem before, the author of the problem
# couldn't be bothered to state how the binary tree is given. Worse, the
# author gave an utterly useless example, carefully crafted to work exactly
# for the given input. But what if we were to make a tiny change? Suppose
# the 7 was a right child of 2? Then what? How would that tree look like?
# 
# Second, what does having the input as a binary tree actually contribute
# to the problem? We have a set of numbers, and we need to replace each number
# with the difference of the sum of all the numbers, and said number. It
# does not matter one iota whether the numbers are in a tree (let alone how
# they are distributed in a tree), or in a list, or in an array. We'd still
# get the set of numbers as output.
# 
# We therefore decide to completely ignore the binary tree aspect of the
# problem. We take sets of numbers: each line of standard input is taken as
# a different set of whitespace separated numbers, and we write the result
# to standard output, one set on each line.
#

use List::Util qw [sum];

while (<>) {
    my $sum = sum my @num = /-?[0-9]+/g;
    say join " " => map {$sum - $_} @num;
}
