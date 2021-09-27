#!/usr/bin/perl
# 
# Task 1: "Consecutive Arrays
# 
# You are given a sorted list of unique positive integers.
# 
# Write a script to return list of arrays where the arrays are consecutive
# integers.
# 
# Example 1:
# 
#    Input:  (1, 2, 3, 6, 7, 8, 9)
#    Output: ([1, 2, 3], [6, 7, 8, 9])
# 
# Example 2:
# 
#    Input:  (11, 12, 14, 17, 18, 19)
#    Output: ([11, 12], [14], [17, 18, 19])
# 
# Example 3:
# 
#    Input:  (2, 4, 6, 8)
#    Output: ([2], [4], [6], [8])
# 
# Example 4:
# 
#    Input:  (1, 2, 3, 4, 5)
#    Output: ([1, 2, 3, 4, 5])
# "
# 
# My notes: easy, should be able to do this in 1-pass.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
#use Data::Dumper;

my $debug=0;
die "Usage: consecutive-arrays [-d|--debug] list_numbers\n".
    "       eg. 1 2 3 4 5 6 7 8 9\n" unless
	GetOptions( "debug"=>\$debug ) && @ARGV>0;

my $prev = shift @ARGV;
my @curr = ($prev);
my @all;
say "debug: curr = ($prev)" if $debug;

# processing
foreach my $item (@ARGV)
{
	if( $item == $prev+1 )
	{
		say "debug: extend curr by $item" if $debug;
		push @curr, $item;
		$prev++;
	} else {
		push @all, [@curr];
		say "debug: add curr - ". join(',',@curr). " to all" if $debug;
		say "debug: start new curr - ($item)" if $debug;
		@curr = $item;
		$prev = $item;
	}
}
push @all, [@curr];
say "debug: \@end add curr - ". join(',',@curr). " to all" if $debug;

# output
my $out = join(', ', map { "[".join(', ',@$_)."]" } @all );
say "($out)";
