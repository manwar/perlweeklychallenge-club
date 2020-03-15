#!/usr/bin/perl
#
# Task 1: "Merge Intervals
#
# Write a script to merge the given intervals whereever possible.
# 
#     [2,7], [3,9], [10,12], [15,19], [18,22]
# 
# The script should merge [2, 7] and [3, 9] together to return [2, 9].
# 
# Similarly it should also merge [15, 19] and [18, 22] together to return [15, 22].
# 
# The final result should be something like below:
# 
# [2, 9], [10, 12], [15, 22]
# "
# 
# My notes: Fine, but why wouldn't we also merge [2,9] and [10,12] to give
# [2,12]?  I think we would.  The immediate thought to implement this is
# to collapse all ranges to an integer set, and then reconstruct the minimal
# sequence of ranges direct from the set.
# 

use feature 'say';
use strict;
use warnings;
#use Function::Parameters;
#use Data::Dumper;

die "Usage: int-sequences A B [C D [E F]]...\n" if @ARGV % 2 == 1;

# build %on: a set of all integers marked "on" by the ranges

my %on;
my $min = 1000000;
my $max = -1;

while( @ARGV >= 2 )
{
	( my $a, my $b, @ARGV ) = @ARGV;
	die "int-sequences: a=$a, b=$b, a>b\n" if $a>$b;
	foreach my $i ($a..$b)
	{
		$on{$i}++;
		$min = $i if $i<$min;
		$max = $i if $i>$max;
	}
}

#say "min=$min, max=$max";


# now, produce the sequence of ranges from %on, using min and max

my $start = my $end = $min;
for(;;)
{
	while( $on{$end+1} )
	{
		$end++;
	}
	say "[$start - $end]";
	$start = $end+1;
	while( $start<=$max && ! $on{$start} )
	{
		$start++;
	}
last if $start>$max;
	$end = $start;
}
