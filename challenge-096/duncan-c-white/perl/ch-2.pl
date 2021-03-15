#!/usr/bin/perl
# 
# Task 2: "Edit Distance
# 
# You are given two strings $S1 and $S2.
# 
# Write a script to find out the minimum operations required to convert
# $S1 into $S2. The operations can be insert, remove or replace a
# character. Please check out https://en.wikipedia.org/wiki/Edit_distance
# for more information.
# 
# Example 1:
# 
# 	Input: $S1 = "kitten"; $S2 = "sitting"
# 	Output: 3
# 
#	Operation 1: replace 'k' with 's'
#	Operation 2: replace 'e' with 'i'
#	Operation 3: insert 'g' at the end
# 
# Example 2:
# 
# 	Input: $S1 = "sunday"; $S2 = "monday"
# 	Output: 2
# 
# 	Operation 1: replace 's' with 'm'
# 	Operation 2: replace 'u' with 'o'
# "
# 
# My notes: reading the Wikipedia page, the naive recursive implementation
# sounds good enough to me, even though it's hideously inefficent.
# The various iterative versions sound clever, especially the one which
# only stores two rows, but I can't be bothered.
#
# (note that there are several CPAN modules which do this, but solving a
# Perl Challenge by "use Text::Levenshtein" seems like cheating).
#

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
use Data::Dumper;
use List::Util qw(min);

my $debug=0;
die "Usage: edit-distance [--debug] A B\n" unless
	GetOptions( "debug" => \$debug ) && @ARGV==2;
my( $a, $b ) = @ARGV;

my $ed = lev($a, $b);
say $ed;

#
# my $ed = lev($a, $b);
#	Calculate and return the Levenshtein edit distance between $a and $b.
#	Naive recursive implmentation, basically:
#		len(a), if len(b)==0
#		len(b), if len(a)==0
#		lev(tail(a),tail(b), if a[0]==b[0]
#		else 1 + min(
#			lev(tail(a),b),
#			lev(a,tail(b)),
#			lev(tail(a),tail(b)) )
#
fun lev( $a, $b )
{
	return length($a) if length($b)==0;

	return length($b) if length($a)==0;

	# if a[0]==b[0]: lev(tail(a),tail(b)
	if( substr($a,0,1) eq substr($b,0,1) )
	{
		return lev( substr($a,1), substr($b,1) );
	}

	# 1 + min(
	#	lev(tail(a),b),
	#	lev(a,tail(b)),
	#	lev(tail(a),tail(b)) )
	return 1 + min(
		lev(substr($a,1), $b),
		lev($a,substr($b,1)),
		lev(substr($a,1), substr($b,1))
	);
}
