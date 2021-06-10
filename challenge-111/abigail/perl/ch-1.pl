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
# Run as: perl ch-1.pl [bsearch] < input-file
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
# time reading data anyway.
#
# Just to cover our bases, we'll do two implementation. Without arguments,
# we'll do that fast, hash bases, implementation. If the program is
# given the 'bsearch' argument, we will make use of a subroutine which
# takes a 2-d matrix and a target number as parameters, and which uses
# a bog standard binary search implementation to find out whether the
# target exists.
#

my $MATRIX_SIZE = 5;

my $HASH    = 0;
my $BSEARCH = 1;

my $TYPE = $HASH;
   $TYPE = $BSEARCH if @ARGV && $ARGV [0] eq "bsearch";

@ARGV = ();

if ($TYPE == $HASH) {
    #
    # Read in a matrix of data
    #
    my %matrix;
    @matrix {<> =~ /-?[0-9]+/g} = () for 1 .. $MATRIX_SIZE; 

    #
    # Print 0/1 depending on whether the given number is in the matrix or not.
    #
    chomp, say exists $matrix {$_} || 0 while <>;

    exit;
}

if ($TYPE == $BSEARCH) {
    #
    # Use binary search to find a target value into a sorted set.
    #
    my sub bsearch ($matrix, $target) {
        my ($min, $max) = (0, $MATRIX_SIZE * $MATRIX_SIZE);
        while ($min < $max) {
            use integer;
            my $mid = ($min + $max) / 2;
            #
            # To map a 1-d coordinate c to a 2-d pair x, y, we use
            # x = floor (c / size), y = c % size.
            # 
            my $cmp = $$matrix [$mid / $MATRIX_SIZE]
                               [$mid % $MATRIX_SIZE] <=> $target;
            if    ($cmp < 0) {$min = $mid + 1}
            elsif ($cmp > 0) {$max = $mid}
            else  {return 1}
        }
        return (0)
    }

    #
    # Read in the matrix
    #
    my $matrix = [map {[<> =~ /-?[0-9]+/g]} 1 .. $MATRIX_SIZE];

    #
    # Check for existence for the rest of the data
    #
    say bsearch ($matrix, $_) for <>;

    exit;
}
