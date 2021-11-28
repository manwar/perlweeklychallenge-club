#!/usr/bin/perl
# 
# TASK #2 - Multiplication Table
# 
# You are given 3 positive integers, $i, $j and $k.
# 
# Write a script to print the $kth element in the sorted multiplication
# table of $i and $j.
# 
# Example 1
# 
# 	Input: $i = 2; $j = 3; $k = 4
# 	Output: 3
# 
# Since the multiplication of 2 x 3 is as below:
# 
#     1 2 3
#     2 4 6
# 
# The sorted multiplication table:
# 
#     1 2 2 3 4 6
# 
# Now the 4th element in the table is "3".
# 
# Example 2
# 
# 	Input: $i = 3; $j = 3; $k = 6
# 	Output: 4
# 
# Since the multiplication of 3 x 3 is as below:
# 
#     1 2 3
#     2 4 6
#     3 6 9
# 
# The sorted multiplication table:
# 
#     1 2 2 3 3 4 6 6 9
# 
# Now the 6th element in the table is "4".
# 
# MY NOTES: Sounds pretty easy.  The table's ith row is (1..$j) * $i.
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Getopt::Long;
use Data::Dumper;

my $debug = 0;

die "Usage: m-t [-d|--debug] I J K\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==3;
my( $i, $j, $k ) = @ARGV;

my @table;

foreach my $row (1..$i)
{
	foreach my $col (1..$j)
	{
		push @table, $col*$row;
	}
}
#die Dumper \@table;

@table = sort @table;

say $table[$k-1];
