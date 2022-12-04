#!/usr/bin/perl
# 
# Task 2: Equal Distribution
# 
# You are given a list of integers greater than or equal to zero, @list.
# 
# Write a script to distribute the number so that each members are
# same. If you succeed then print the total moves otherwise print -1.
# 
# Please follow the rules (as suggested by Neils van Dijke [2022-11-21 13:00]
# 
# 1) You can only move a value of '1' per move
# 2) You are only allowed to move a value of '1' to a direct neighbor/adjacent cell
# 
# Example 1:
# 
# Input: @list = (1, 0, 5)
# Output: 4
# 
# Move #1: 1, 1, 4
# (2nd cell gets 1 from the 3rd cell)
# 
# Move #2: 1, 2, 3
# (2nd cell gets 1 from the 3rd cell)
# 
# Move #3: 2, 1, 3
# (1st cell get 1 from the 2nd cell)
# 
# Move #4: 2, 2, 2
# (2nd cell gets 1 from the 3rd cell)
# 
# Example 2:
# 
# Input: @list = (0, 2, 0)
# Output: -1
# 
# It is not possible to make each same.
# 
# Example 3:
# 
# Input: @list = (0, 3, 0)
# Output: 2
# 
# Move #1: 1, 2, 0
# (1st cell gets 1 from the 2nd cell)
# 
# Move #2: 1, 1, 1
# (3rd cell gets 1 from the 2nd cell)
# 
# MY NOTES: Hmm..  If I'm understanding that right, it's two passes:
# 1. repeatedly find two adjacent cells whose absolute difference > 1
# and transfer one from the bigger cell to the smaller cell.
# 2. repeatedly find 2 adjacent cells where firstvalue < secondvalue
# and transfer one from secondvalue to firstvalue
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-2.pl
# into C (look in the C directory for the translation)
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
use Data::Dumper;


my $debug=0;
die "Usage: same-list [--debug] intlist\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV>0;

my @list = split(/,/, join( ',', @ARGV ));

die "same-list: need a list of > 1 elements\n" if @list<2;


=pod

=head2 my $pos = find_pair_diff_gt_1(@list);

Find the position $pos of the first element of the first pair in @list
where the absolute difference between list[$pos] and list[pos+1] is > 1.
Return -1 if none.

=cut
fun find_pair_diff_gt_1( @list )
{
	for( my $pos=0; $pos<@list-1; $pos++ )
	{
		return $pos if abs( $list[$pos] - $list[$pos+1] ) > 1;
	}
	return -1;
}



=pod

=head2 my $pos = find_pair_f_lt_s(@list);

Find the position $pos of the first element of a pair in @list
where list[$pos] < list[pos+1].  Return -1 if none.

=cut
fun find_pair_f_lt_s( @list )
{
	for( my $pos=0; $pos<@list-1; $pos++ )
	{
		return $pos if $list[$pos] < $list[$pos+1];
	}
	return -1;
}


my $nmoves = 0;

say "starting first pass" if $debug;

# first pass: repeatedly find two adjacent cells whose absolute difference > 1
# and transfer one from the bigger cell to the smaller cell.
while( (my $pos = find_pair_diff_gt_1(@list)) != -1 )
{
	say "debug: found pos $pos, list=", join(',',@list) if $debug;
	if( $list[$pos] < $list[$pos+1] )
	{
		$list[$pos]++;
		$list[$pos+1]--;
	} else
	{
		$list[$pos]--;
		$list[$pos+1]++;
	}
	$nmoves++;
}


say "starting second pass" if $debug;

# second pass: repeatedly find 2 adjacent cells where firstvalue < secondvalue
# and transfer one from secondvalue to firstvalue
while( (my $pos = find_pair_f_lt_s(@list)) != -1 )
{
	say "debug: found pos $pos, list=", join(',',@list) if $debug;
	$list[$pos]++;
	$list[$pos+1]--;
	$nmoves++;
}

my $firstel = $list[0];
my $nsame = grep { $_ == $firstel } @list;
my $success = $nsame == @list ? 1 : 0;

say "debug: after $nmoves moves, nsame=$nsame, success=$success, final list=", join(',',@list) if $debug;
say $success ? $nmoves : -1;
