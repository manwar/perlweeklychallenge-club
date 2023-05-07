#!/usr/bin/perl
#
# Task 2: Number Placement
# 
# You are given a list of numbers having just 0 and 1. You are also given
# placement count (>=1).
# 
# Write a script to find out if it is possible to replace 0 with 1 in the
# given list. The only condition is that you can only replace when there
# is no 1 on either side. Print 1 if it is possible otherwise 0.
# 
# Example 1:
# 
#   Input: @numbers = (1,0,0,0,1), $count = 1
#   Output: 1
# 
#   You are asked to replace only one 0 as given count is 1.
#   We can easily replace middle 0 in the list i.e. (1,0,1,0,1).
# 
# Example 2:
# 
#   Input: @numbers = (1,0,0,0,1), $count = 2
#   Output: 0
# 
#   You are asked to replace two 0's as given count is 2.
#   It is impossible to replace two 0's.
# 
# Example 3:
# 
#   Input: @numbers = (1,0,0,0,0,0,0,0,1), $count = 3
#   Output: 1
# 
# MY NOTES: ok, so it means "can you replace COUNT consecutive
# zeros with ones, where neither the preceding or following number is 1".
# i.e. where there is either NO preceding or following number (the COUNT
# consecutive zeros start or end of the sequence), or a 0 precedes and
# follows our COUNT consecutive zeros.
# So I guess we just run a start-point along the sequence and check.
# 
# GUEST LANGUAGE: As a bonus, I had a go at translating ch-2.pl into C,
# look in the C/ directory for that.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;
use Function::Parameters;

my $debug=0;
die "Usage: number-replacement [--debug] count bitstring\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV == 2;
my( $count, $bitstring ) = @ARGV;

if( $debug )
{
	say "debug: count=$count, bitstring=$bitstring";
}

die "number-replacement: bitstring $bitstring must only contain 0 and 1\n"
	if $bitstring =~ /[^01]/;

#
# my $canfind = find_pat( $startpos, $count, $bitstring, $len );
#	Return true iff we can find the desired pattern ($count zeros
#	neither preceded nor followed by a one) in $bitstring.
#
fun find_pat( $startpos, $count, $bitstring, $len )
{
	my $zeroes = '0' x $count;
	return 0 unless substr($bitstring,$startpos,$count) eq $zeroes;
	say "debug: found $zeroes starting at $startpos" if $debug;
	if( $startpos > 0 )
	{
		my $p = substr($bitstring,$startpos-1,1);
		return 0 if $p eq '1';
		say "debug: preceding ($p) is not 1" if $debug;
	}
	my $followpos = $startpos + $count;
	if( $followpos < $len )
	{
		my $f = substr($bitstring,$followpos,1);
		#say "debug: following=$f" if $debug;
		say "debug: following ($f) is not 1" if $debug;
	}
	say "found pattern at startpos $startpos" if $debug;

	return 1;
}


my $len = length( $bitstring );
foreach my $startpos (0..$len-$count)
{
	#say "trying find_pat starting at $startpos" if $debug;
	if( find_pat( $startpos, $count, $bitstring, $len ) )
	{
		#say "debug: succeeded at startpos=$startpos" if $debug;
		substr( $bitstring, $startpos, $count, '1' x $count );
		say "1 (changed bitstring to $bitstring)";
		exit 0;
	}
}
say 0;
