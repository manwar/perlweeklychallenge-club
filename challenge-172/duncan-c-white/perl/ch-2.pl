#!/usr/bin/perl
# 
# Task 2: Five-number Summary
# 
# You are given an array of integers.  Write a script to compute the
# five-number summary of the given set of integers.
# You can find the definition and example in the wikipedia page:
#   https://en.wikipedia.org/wiki/Five-number_summary
# 
# MY NOTES: Nice and simple: sort the data, pick the median, first and third
# quartile values.  Note that the median can be the average (mean) of the
# two central values if the #values is even.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;

my $debug=0;
die "Usage: five-number-summary [--debug] list_of_ints\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV>1;

my @n = sort { $a <=> $b } @ARGV;
say "debug: sorted ", join(',', @n ) if $debug;


#
# my $median = median( @n );
#	Calculate the median value in the sorted array @n.
#
sub median
{
	my( @n ) = @_;
	my $midpos = int(@n/2);
	my $median = @n%2 == 0 ? ($n[$midpos-1]+$n[$midpos])/2 : $n[$midpos];
	return $median;
}


my $median = median( @n );

my $midpos = int(@n/2);
say "debug: midpos=$midpos" if $debug;

my @h1 = @n[0..$midpos-1];

$midpos++ if @n%2 != 0;
my @h2 = @n[$midpos..@n-1];

say "debug: h1 = ", join(',',@h1), ", h2 = ", join(',',@h2)
	if $debug;

my $firstq = median( @h1 );
my $thirdq = median( @h2 );

my $min = $n[0];
my $max = $n[-1];

printf "   %5.1f\n", $median;
printf "%5.1f  %5.1f\n", $firstq, $thirdq;
printf "%5.1f  %5.1f\n", $min, $max;
