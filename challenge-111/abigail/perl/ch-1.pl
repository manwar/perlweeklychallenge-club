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
# This challenge confuses me. We're basically asked to find a number
# in a sorted list. Which in languages without hashes one would solve
# with binary search (yielding an O (log N) solution), and in languages
# with hashes you'd use a hash (yielding an O (1) (expected) time solution).
# Sure, the hash takes linear preprocessing time, but since we're asked
# to write a script, we're spending linear time reading in the data
# anyway.
#
# Perhaps the intend was a subroutine which takes a matrix and a target
# number, but that was not what is being asked. The challenge explicitly
# asks for *a script*, which means we have to spend a linear amount of 
# time reading data anyway. So, that's what you get.
#
# The only part where we use the fact we are given a matrix is for the
# input: the first five lines are assumed to contain the matrix. The
# rest of the input is taken as numbers to search for.
#

my $MATRIX_SIZE = 5;

#
# Read in a matrix of data
#
my %matrix;
@matrix {<> =~ /-?[0-9]+/g} = () for 1 .. $MATRIX_SIZE; 

#
# Print 0/1 depending on whether the given number is in the matrix or not.
#
chomp, say exists $matrix {$_} || 0 while <>
