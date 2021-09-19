#!/usr/bin/perl
# 
# Task 1: "Odd Number
# 
# You are given an array of positive integers, such that all the numbers
# appear even number of times except one number.
# 
# Write a script to find that integer.
# 
# Example 1
# 
#   Input: @N = (2, 5, 4, 4, 5, 5, 2)
#   Output: 5
#    as it appears 3 times in the array where as all other numbers 2 and
#    4 appears exactly twice.
# 
# Example 2
# 
#   Input: @N = (1, 2, 3, 4, 3, 2, 1, 4, 4)
#   Output: 4
# "
# 
# My notes: easy, let's use a frequency hash.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;

my $debug=0;
die "Usage: odd-frequency [-d|--debug] list_numbers\n".
    "       eg. 1 2 3 4 3 2 1 4 4\n" unless
	GetOptions( "debug"=>\$debug ) && @ARGV>0;

my %freq;
map { $freq{$_}++ } @ARGV;

my @odd = grep { $freq{$_} % 2 == 1 } sort keys %freq;

say Dumper \%freq if $debug;
say Dumper \@odd if $debug;

my $n = @odd;
if( $n == 1 )
{
	my $odd = shift @odd;
	say $odd;
} else
{
	die "odd-frequency: $n odd-frequency values: ". join(',',@odd) ."\n";
}
