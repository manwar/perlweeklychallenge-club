#!/usr/bin/perl
# 
# Task 1: Special Quadruplets
# 
# You are given an array of integers.
# 
# Write a script to find out the total special quadruplets for the given array.
# Special Quadruplets are such that satisfies the following 2 rules.
# 1) nums[a] + nums[b] + nums[c] == nums[d]
# 2) a < b < c < d
# 
# Example 1
# 
#   Input: @nums = (1,2,3,6)
#   Output: 1
# 
#   Since the only special quadruplets found is $nums[0] + $nums[1] + $nums[2] == $nums[3].
# 
# Example 2
# 
#   Input: @nums = (1,1,1,3,5)
#   Output: 4
# 
#   $nums[0] + $nums[1] + $nums[2] == $nums[3]
#   $nums[0] + $nums[1] + $nums[3] == $nums[4]
#   $nums[0] + $nums[2] + $nums[3] == $nums[4]
#   $nums[1] + $nums[2] + $nums[3] == $nums[4]
# 
# Example 3
# 
#   Input: @nums = (3,3,6,4,5)
#   Output: 0
# 
# MY NOTES: seems pretty easy. condition (2) implies 4 for loops, a, b, c and d
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-1.pl
# into C (look in the C directory for the translation)
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;

my $debug=0;
die "Usage: special-quads [--debug] intlist\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV>0;

=pod

=head2 my $n = count_special_quads( @list );

Find all special quads in @list, and count them.
In debug mode, list all the special quads we find.

=cut
sub count_special_quads
{
	my( @list ) = @_;
	my $nel = @list;
	my $result = 0;
	for( my $a = 0; $a < $nel-3; $a++ )
	{
	   for( my $b = $a+1; $b < $nel-2; $b++ )
	   {
	      for( my $c = $b+1; $c < $nel-1; $c++ )
	      {
	      	 my $sum = $list[$a] + $list[$b] + $list[$c];
	         for( my $d = $c+1; $d < $nel; $d++ )
	         {
		    next unless $list[$d] == $sum;
		    if( $debug )
		    {
		    	say "found sq $a-$b-$c-$d: $list[$a]+$list[$b]+$list[$c]==$list[$d]";
		    }
		    $result++;
	         }
	      }
	   }
	}
	return $result;
}



my @list = split( /,/, join(',',@ARGV) );

die "special-quads: need at least 4 ints in list\n" unless @list>3;

my $n = count_special_quads( @list );
say $n;
