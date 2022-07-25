#!/usr/bin/perl
# 
# Task 2: Sylvester's sequence
# 
# Write a script to generate first 10 members of Sylvester's sequence. For
# more informations, please refer to the wikipedia page:
#   https://en.wikipedia.org/wiki/Sylvester%27s_sequence
# 
# (In summary, each term of the sequence is the product of the previous
# terms, plus one. The first few terms of the sequence are 2, 3, 7, 43, 1807)
# 
# Output
# 
# 2
# 3
# 7
# 43
# 1807
# 3263443
# 10650056950807
# 113423713055421844361000443
# 12864938683278671740537145998360961546653259485195807
# 165506647324519964198468195444439180017513152706377497841851388766535868639572406808911988131737645185443
# 
# MY NOTES: Also very easy, although the numbers grow ridiculously fast.
# Sounds like a job for BigInt.
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
use bigint;

my $debug=0;
die "Usage: sylvester-numbers [--debug] N (default 10)\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV<2;

my $n = shift // 10;

my $p = 2;
say $p;

foreach my $i (1..$n-1)
{
	my $next = $p + 1;
	say $next;
	$p *= $next;
}
