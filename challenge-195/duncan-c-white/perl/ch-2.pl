#!/usr/bin/perl
# 
# Task 2: Most Frequent Even
# 
# You are given a list of numbers, @list.
# 
# Write a script to find most frequent even numbers in the list. In case you
# get more than one even numbers then return the smallest even integer. For
# all other case, return -1.
# 
# Example 1
# 
# Input: @list = (1,1,2,6,2)
# Output: 2 as there are only 2 even numbers 2 and 6 and of those 2 appears
# the most.
# 
# Example 2
# 
# Input: @list = (1,3,5,7)
# Output: -1 since no even numbers found in the list
# 
# Example 3
# 
# Input: @list = (6,4,4,6,1)
# Output: 4 since there are only two even numbers 4 and 6. They both
# appear the equal number of times, so pick the smallest.
# 
# MY NOTES: very easy; select even numbers; build a freq hash, sort by freqs..
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-2.pl
# into C (look in the C directory for the translation)
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use List::Util qw(max);
use Function::Parameters;
use Data::Dumper;


my $debug=0;
die "Usage: most-freq-even [--debug] list(int)\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV>1;

my @list = split( /,/, join( ',', @ARGV ) );

=pod

=head2 my $mfe = mfe( @list );

Find and return the most-frequent-even number in @list,
as documented above.

=cut
fun mfe( @list )
{
	# discard odd
	@list = grep { $_ % 2 == 0 } @list;

	return -1 unless @list;

	# build freq hash
	my %freq;
	map { $freq{$_}++ } @list;

	# find max freq
	my $max = max( values %freq );

	# find elements with max freq
	@list = grep { $freq{$_} == $max } keys %freq;

	# sort them numerically, so the smallest value comes first
	@list = sort { $a <=> $b } @list;

	#die Dumper(\@list);

	# that's our answer
	return $list[0];
}

my $mfe = mfe( @list );
say $mfe;
