#!/usr/bin/perl
# 
# Task 1: Sorted Matrix
# 
# You are given a n x n matrix where n >= 2.
# Write a script to find 3rd smallest element in the sorted matrix.
# 
# Example 1
# 
#   Input: @matrix =  [3, 1, 2], [5, 2, 4], [0, 1, 3]
#   Output: 1
# 
#   The sorted list of the given matrix: 0, 1, 1, 2, 2, 3, 3, 4, 5.
#   The 3rd smallest of the sorted list is 1.
# 
# Example 2
# 
#   Input: @matrix = ([2, 1], [4, 5])
#   Output: 4
# 
#   The sorted list of the given matrix: 1, 2, 4, 5.
#   The 3rd smallest of the sorted list is 4.
# 
# Example 3
# 
#   Input: @matrix = ([1, 0, 3], [0, 0, 0], [1, 2, 1])
#   Output: 0
# 
#   The sorted list of the given matrix: 0, 0, 0, 0, 1, 1, 1, 2, 3.
#   The 3rd smallest of the sorted list is 0.
# 
# MY NOTES: So basically flatten the matrix onto an array, sort it,
# pick out element 2.. easy.  BTW, why does the matrix have to be square,
# any matrix could be flattened and sorted.
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-1.pl into C
# (look in the C directory for that).
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;
use List::Util qw(any);

my $debug=0;
die "Usage: third-from-sorted-matrix [--debug] list-of-rows-in-csv\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV>0;

my @m = map { [ split( /,/, $_ ) ] } @ARGV;

my $cols = @{$m[0]};
my $rows = @m;

say "m: ", Dumper(\@m) if $debug;

die "sorted-matrix: all rows must be $cols columns\n" if any { @$_ != $cols } @m;
die "sorted-matrix: need at least 3 elements\n" if $rows * $cols < 3;

# flatten
my @arr;
foreach my $row (@m)
{
	push @arr, @$row;
}

# sort
@arr = sort @arr;

# pick third
say $arr[2];
