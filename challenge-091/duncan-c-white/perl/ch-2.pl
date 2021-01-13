#!/usr/bin/perl
#
# Task 2: "Jump Game
# 
# You are given an array of positive numbers @N, where value at each index
# determines how far you are allowed to jump further.  Write a script to
# decide if you can jump to the last index. Print 1 if you are able to
# reach the last index otherwise 0.
# 
# Example 1:
# 
# 	Input: @N = (1, 2, 1, 2)
#	Output: 1
# 
# as we jump one place from index 0 and then twoe places from index 1 to
# reach the last index.
# 
# Example 2:
# 
# 	Input: @N = (2,1,1,0,2)
# 	Output: 0
# 
# it is impossible to reach the last index. as we jump two places from index
# 0 to reach index 2, followed by one place jump from index 2 to reach the
# index 3. once you reached the index 3, you can't go any further because
# you can only jump 0 position further.
# "
# 
# My notes: does it mean "decide if you can jump to the last index, starting at index 0"?
# all the examples show that, so I'm going to assume that's what it means.  But it
# doesn't say that explicitly - reading at first I thought you would have a
# free choice of where to start, so would have to search "starting at pos 0",
# "starting at pos 1"... etc.  Negative numbers would also make it more interesting.
# 

use strict;
use warnings;
use Data::Dumper;
use Function::Parameters;
use feature 'say';
use Getopt::Long;

my $debug = 0;
die "Usage: jump-game [--debug] VALUES\n" unless
	GetOptions( "debug" => \$debug ) &&
	@ARGV>1;
my @v = @ARGV;

my @chain = gettolast( 0, $#v, @v );
say 0 unless @chain;
say "1" if ! $debug && @chain;
say "1 (@chain)" if $debug && @chain;

#
# my @chain = gettolast( $startpos, $goalpos, @v );
#	Can we get from position $startpos to $goalpos using the values in
#	@v, under the jump game rules?  return the chain (the list of positions
#	we visit) iff we can, () otherwise.
#
fun gettolast( $startpos, $goalpos, @v )
{
	my $pos = $startpos;
	my @chain = ( $pos );
	while(1)
	{
		return @chain if $pos == $goalpos;
		return () if $pos > $#v;
		return () if $v[$pos] == 0;
		say "debug: pos=$pos, v[$pos]=$v[$pos]" if $debug;
		$pos += $v[$pos];
		push @chain, $pos;
		say "advance to new pos $pos" if $debug;
	}
}
