#!/usr/bin/perl
# 
# TASK #2 - Split Number
# 
# You are given a perfect square.
# 
# Write a script to figure out if the square root the given number is same
# as sum of 2 or more splits of the given number.
# 
# Example 1
# 
# 	Input: $n = 81
# 	Output: 1
# 
# 	Since, sqrt(81) = 8 + 1
# 
# Example 2
# 
# 	Input: $n = 9801
# 	Output: 1
# 
# 	Since, sqrt(9801) = 98 + 0 + 1
# 
# Example 3
# 
# 	Input: $n = 36
# 	Output: 0
# 
# 	Since, sqrt(36) != 3 + 6
# 
# MY NOTES: Sounds pretty easy.  The only tricky part is identifying all
# distinct "splits" of the number.  Is there a "binary counting" method,
# where bit i being true means: split the number between digit i and i+1?
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Getopt::Long;
use Data::Dumper;
use List::Util qw(sum);

my $debug = 0;

die "Usage: split-numbers [-d|--debug] N\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==1;
my $n = shift @ARGV;
my $sq = int(sqrt($n));
die "$n is not a perfect square\n" if $n != $sq*$sq;


#
# my @pieces = BinarySplit( $str, $count );
#	Split $str using the binary count $count
#	and return the list of split pieces.  Each bit of
#	the count $count determines whether to split the
#	string at the corresponding letter - or
#	equivalently, whether to insert a ',' before the letter.
#
fun BinarySplit( $str, $count )
{
	$str =~ s/^(.)//;		# always add the first letter
	my $result = $1;

	while( $str =~ s/^(.)// )
	{
		my $letter = $1;
		$result .= ',' if $count&1;
		$result .= $letter;
		$count >>= 1;
	}
	return split(/,/,$result);
}


#die Dumper BinarySplit( "hello", 0b100 );


#
# my $issplit = SplitSum( $n, $sum );
#	Return 1 iff the digits of $n can be split at
#	any position set of positions st the sum of those
#	split values is $sum.  Return 0 otherwise.
#	For example SplitSum(81,9) is true as 9 = 8 + 1
#
fun SplitSum( $n, $sum )
{
	my $bits = length($n)-1;
	my $twopower = 2**$bits;
	say "debug: twopower=$twopower" if $debug;
	# ignore i=0, that doesn't split $n at all, and sum($n)==$n
	# which is always > $sqrt($n) so can't be an answer
	for( my $i=1; $i<$twopower; $i++ )
	{
		my @pieces = BinarySplit( $n, $i );
		my $actualsum = sum(@pieces);
		say "debug: i=$i, want sum=$sum, ".join(',',@pieces).
		    ", got sum=$actualsum, want $sum" if $debug;
		return 1 if $actualsum == $sum;
	}
	return 0;
}


my $issplit = SplitSum( $n, $sq );
say $issplit;
