#!/usr/bin/perl
# 
# Task 1: Kill and Win
# 
# You are given a list of integers.  Write a script to get the maximum points.
# You are allowed to take out (kill) any integer and remove from the list.
# However if you do that then all integers exactly one-less or one-more would
# also be removed. Find out the total of integers removed.
# 
# Example 1
# 
#   Input: @int = (2, 3, 1)
#   Output: 6
# 
#   First we delete 2 and that would also delete 1 and 3. So the maximum
#   points we get is 6.
# 
# Example 2
# 
#   Input: @int = (1, 1, 2, 2, 2, 3)
#   Output: 11
# 
#   First we delete 2 and that would also delete both the 1's and the
#   3. Now we have (2, 2).
#   Then we delete another 2 and followed by the third deletion of 2. So
#   the maximum points we get is 11.
# 
# MY NOTES: very easy recursive solution with accumulating points so far.
#     Reduce search space by picking each DISTINCT value at each stage,
#     not EACH value.
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-1.pl into C
# (look in the C directory for that).
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use List::Util qw(max sum);
use Data::Dumper;

my $debug=0;
die "Usage: kaw [--debug] list-of-ints\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV>0;

my @list = split( /,/, join(',',@ARGV) );

say "list: ", join(',',@list) if $debug;

my $max = 0;


#
# findall( $sumsofar, @list );
#	Given a sumsofar and a list, find all "kill-and-win"
#	paths through the list, updating $max with the maximum
#	of all total sums of each complete path.
#
sub findall
{
	my( $sumsofar, @list ) = @_;
	if( @list == 0 )
	{
		$max = max( $max, $sumsofar );
		return;
	}
	# find all distinct values in list
	my %set = map { $_ => 1 } @list;
	foreach my $v (keys %set)
	{
		# ok, pick $v..

		# kaw rule: remove all $v-1 and $v+1 values
		my @newl = grep { $_ != $v-1 && $_ != $v+1 } @list;

		# and ONE $v value
		my $nvseen = 0;
		@newl = grep { $_ != $v || ( $_ == $v && $nvseen++ > 0) } @newl;

		my @deleted = grep { $_ == $v-1 || $_ == $v+1 } @list;
		push @deleted, $v;
		my $news = $sumsofar + sum(@deleted);
		say "debug: kaw: list=", join(',',@list),
		    ", v=$v, deleted=", join(',',@deleted),
		    ", newl=", join(',',@newl), ", newsum=$news" if $debug;
		findall( $news, @newl );
	}
}


findall( 0, @list );
say $max;
