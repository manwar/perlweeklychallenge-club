#!/usr/bin/perl
#
# Task 2: "Insert Interval
# 
# You are given a set of sorted non-overlapping intervals and a new interval.
# 
# Write a script to merge the new interval to the given set of intervals.
# 
# Example 1:
# 	Input $S = (1,4), (8,10); $N = (2,6)
# 	Output: (1,6), (8,10)
# 
# Example 2:
# 	Input $S = (1,2), (3,7), (8,10); $N = (5,8)
# 	Output: (1,2), (3,10)
# 
# Example 3:
# 	Input $S = (1,5), (7,9); $N = (10,11)
# 	Output: (1,5), (7,9), (10,11)
# "
# 
# My notes: interesting. Sounds familiar.  let's use from:to as interval syntax.
# 

use strict;
use warnings;
use Data::Dumper;
use Function::Parameters;
use feature 'say';
use Getopt::Long;

my $debug = 0;
die "Usage: insert-interval [--debug] newinterval interval1 .. intervalN\n" unless
	GetOptions( "debug" => \$debug ) &&
	@ARGV>2;
my( $newint, @int ) = map { validate_interval($_) } @ARGV;

my @result = merge_interval( $newint, @int );
say "$_->[0]:$_->[1]" for @result;


#
# my $validint = validate_interval( $int );
#	Check that $int is a valid interval of the form FROM:TO,
#	with FROM and TO being numbers, and with FROM<=TO.
#	die with error message if it isn't.  Return a validinterval [$from,$to] if it is.
#
fun validate_interval( $int )
{
	die "Usage: insert-interval: bad interval $int, should be of form INT:INT\n"
		unless $int=~ /^(\d+):(\d+)$/;
	my( $from, $to ) = ($1,$2);
	die "Usage: insert-interval: bad interval $int, from $from must be <= to $to\n"
		unless $from<=$to;
	return [ $from, $to ];
}


#
# my @result = merge_interval( $newint, @int );
#	Ok, given $newint (a [from,to] arrayref) and @int, a sorted
#	array of nonoverlapping [from,to] arrayrefs, let's merge $newint
#	and @int, returning @result, the merged sorted array of
#	nonoverlapping [from,to] arrayrefs.
#
fun merge_interval( $newint, @int )
{
	my( $newfrom, $newto ) = @$newint;

	return ($newint) if @int==0;	# empty list of intervals..

	# I'm sure there's a clever way of doing this, I can nearly see my way to it, identifying
	# overlapping intervals (and merging adjacent intervals), but as it's after 11pm on
	# Sunday 27th Dec, let's do it the grunt way, which works as long as the intervals involve
	# positive numbers only (which is what \d+ matches anyway):

	# First: expand all the intervals (new and old) into a number line - an array of booleans
	my @x;				# all default to false
	foreach my $i ($newfrom..$newto)
	{
		$x[$i] = 1;		# set it to true
	}
	foreach my $int (@int)
	{
		foreach my $i ($int->[0]..$int->[1])
		{
			$x[$i] = 1;		# set it to true
		}
	}
	#die Dumper \@x;

	# Second: find all the intervals in @x
	my @result;
	my $from = 0;
	for(;;)
	{
		while( $from <= $#x && ! $x[$from] )
		{
			$from++;
		}
	last if $from > $#x;
		my $to = $from;
		while( $x[$to] )
		{
			$to++;
		}
		say "debug: from=$from, to=".($to-1) if $debug;
		push @result, [$from,$to-1];
		$from = $to;
	}

	return @result;
}


