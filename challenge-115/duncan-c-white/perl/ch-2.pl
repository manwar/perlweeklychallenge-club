#!/usr/bin/perl
# 
# Task 2: "Largest Multiple (Even)
# 
# You are given a list of positive integers (0-9), single digit.
# 
# Write a script to find the largest multiple of 2 that can be formed from the list.
# 
# Examples
# 
#   Input: @N = (1, 0, 2, 6)
#   Output: 6210
# 
#   Input: @N = (1, 4, 2, 8)
#   Output: 8412
# 
#   Input: @N = (4, 1, 7, 6)
#   Output: 7614
# "
# 
# My notes: should be easy (multiple of 2 == even number).  Obvious heuristic is: put biggest digit
# first, but I suppose it's possible that no even numbers would result.  Hell, just try all perms..
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
#use Data::Dumper;

die "Usage: largest-even D D...\n" if @ARGV==0;
my @digits = @ARGV;

die "All values should be decimal digits\n" unless (grep { /^[0-9]$/ } @digits) == @digits;
die "At least one digit must be even\n" if (grep { /^[02468]$/ } @digits) == 0;


#
# try_all_perms( $callback, @digits );
#	Permutation generator: Invoke $callback->( permutation )
#	once for every permutation of @digits.
#
fun try_all_perms( $callback, @digits )
{
	rec_allperm( $callback, [], @digits );
}


#
# rec_allperm( $callback, $prefix, @rest );
#	Recursive all permutations generator.  Given a "permutation prefix" of @$prefix,
#	and a collection of unused digits @rest, for all permutations of @$prefix + @rest,
#	calling $callback->( permutation ) for each complete permutation found.
#
fun rec_allperm( $callback, $prefix, @rest )
{
	foreach my $pos (0..$#rest)
	{
		my $x = $rest[$pos];
		# try with $x first (after @$prefix)
		my @pre = @$prefix;
		push @pre, $x;

		# delete pos $pos from copy of @rest
		my @r = @rest;
		splice( @r, $pos, 1 );

		if( @r == 0 )
		{
			$callback->( @pre );
		} else
		{
			rec_allperm( $callback, \@pre, @r );
		}
	}
}


my $max = 0;

fun eachperm(@perm)
{
	my $p = join('', @perm);
	#say "perm: $p";
	$max = $p if $p > $max && $p % 2 == 0;
}

try_all_perms( \&eachperm, @digits );
say "$max";
