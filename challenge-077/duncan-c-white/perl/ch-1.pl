#!/usr/bin/perl
#
# Task 1: "Fibonacci Sum
#
# You are given a positive integer $N.
# 
# Write a script to find out all possible combination of Fibonacci Numbers
# required to get $N on addition.
# 
# You are NOT allowed to repeat a number. Print 0 if none found.
# 
# Example 1:
# 
# Input: $N = 6
# 
# Output:
#     1 + 2 + 3 = 6
#     1 + 5 = 6
# 
# Example 2:
# 
# Input: $N = 9
# 
# Output:
#     1 + 8 = 9
#     1 + 3 + 5 = 9
# "
# 
# My notes: ok. pretty straightforward, especially after last weeks' first task,
# and I'm glad to see that this week says "not repeated":-)
# Not quite so trivial to do efficiently, my solution generates a lot of
# duplicate solutions (hence the dedup() function), and is very slow for
# large N.
#

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Data::Dumper;

die "Usage: fibonacci-sum target\n" unless @ARGV==1;
my $N = shift;

# let's generate distinct Fibonacci numbers up to N (so skip one of the 1s)
my @fib = (1);
my $a = 1;
my $b = 1;
for(;;)
{
	my $c = $a+$b;
last if $c > $N;
	push @fib, $c;
	$a = $b;
	$b = $c;
}

#die Dumper( \@fib );


#
# my @soln = findsum( $s, \@used, @value );
#	Try to find all lists of non-repeated values from @value (sorted)
#	that sums to $s, given that we've already used @used.  Return a list
#	of all such lists we find.  This list can be () if no lists are found.
#	In each solution, each value is either used once or zero times.
#
fun findsum( $s, $used, @value )
{
	my @result;
	#say "debug: findsum($s, used=@$used, value=@value)";
	foreach my $v (@value)
	{
		#say "debug: findsum($s, used=@$used, v=$v, value=@value)";
		if( $v > $s )
		{
			#say "debug: no solution found, v=$v > s=$s";
			last;
		}

		if( $v == $s )
		{
			my @soln = (@$used,$v);
			push @result, \@soln;
			#say "debug: found solution @soln";
			last;
		}

		# v < s: try solutions with v (for sum s-v) and without v
		my @rest = grep { $_ ne $v } @value;

		# use v:
		push @result, findsum( $s-$v, [@$used,$v], @rest );

		# don't use v
		push @result, findsum( $s, [ @$used ], @rest );
	}
	return @result;
}

#
# my @result = dedup( @soln );
#	Given a list of solutions (each a list of values),
#	deduplicate all solutions.  Return the deduplicated list of lists.
#
fun dedup( @soln )
{
	my %seen;
	my @result = grep { $seen{join(',',sort @$_)}++ == 0 } @soln;
	return @result;
}


my @soln = findsum( $N, [], @fib );
@soln = dedup( @soln );
my $nsoln = @soln;
if( $nsoln )
{
	say "found $nsoln solutions (sum of distinct fibonacci numbers==$N):";
	say join(',',@$_) for @soln;
} else
{
	say "0";
}
