#!/usr/bin/perl
#
# Task 1: "Longest Consecutive Sequence
# 
# You are given an unsorted array of integers @N.
# 
# Write a script to find the longest consecutive sequence. Print 0 if no sequence found.
# 
# Example 1:
# 
# 	Input: @N = (100, 4, 50, 3, 2)
# 	Output: (2, 3, 4)
# 
# Example 2:
# 
# 	Input: @N = (20, 30, 10, 40, 50)
# 	Output: 0
# 
# Example 3:
# 
# 	Input: @N = (20, 19, 9, 11, 10)
# 	Output: (9, 10, 11)
# "
# 
# My notes: clearly defined, sort it first, then walk list looking for sequences
#

use strict;
use warnings;
use feature 'say';
#use Data::Dumper;
use Getopt::Long;

my $debug = 0;
die "Usage: longest-sequence [--debug] array\n" unless
	GetOptions( "debug" => \$debug ) &&
	@ARGV>1;
my @x = sort { $a <=> $b } @ARGV;

# one-pass, extend sequence or start a new one each go

my @seq;		# members of current sequence (empty if not in sequence)
my $next = undef;	# if we're in a sequence, what's the next value expected
my @longestseq;		# members of longest current sequence (empty if no sequence found yet)

foreach my $val (@x)
{
	#say "debug: val=$val, seq=", join(',',@seq);
	unless( @seq )	# not in a sequence? start a new one
	{
		@seq = ($val);
		$next = $val+1;
	} else
	{
		if( $val == $next )	# extend sequence
		{
			push @seq, $val;
			$next++;
		} else
		{
			say "found sequence ", join(',',@seq), ", length ", scalar(@seq) if $debug;
			if( @seq > @longestseq )
			{
				@longestseq = @seq;
			}
			@seq = ( $val );
			$next = $val+1;
		}
	}
}
say "found sequence, ", join(',',@seq), ", length ", scalar(@seq) if $debug;

my $len = @longestseq;
if( $len > 1 )
{
	say join(',',@longestseq);
} else
{
	say 0;
}
