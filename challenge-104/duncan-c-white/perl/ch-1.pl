#!/usr/bin/perl
# 
# Task 1: "FUSC Sequence
# 
# Write a script to generate first 50 members of FUSC Sequence. Please
# refer to http://oeis.org/A002487 for more information.
# 
# The sequence defined as below:
# 
# 	fusc(0) = 0
# 	fusc(1) = 1
# 
# for n > 1:
# 	when n is even: fusc(n) = fusc(n / 2),
# 	when n is odd: fusc(n) = fusc((n-1)/2) + fusc((n+1)/2)
# "
# 
# My notes: looks like a case for Memoize to make this highly recursive
# function efficient.  No, turns out it's quite efficient, so we don't
# even need Memoize!
# 

use strict;
use warnings;
use Function::Parameters;
use feature 'say';
use Getopt::Long;
use Data::Dumper;

my $debug=0;
die "Usage: fusc [--debug]\n"
	unless GetOptions( "debug" => \$debug ) && @ARGV==0;

#
# my $f = fusc($n);
#	Compute and return FUSC($n), as defined above.
#
fun fusc( $n )
{
	die "fusc: $n must be +ve\n" if $n<0;
	return $n if $n < 2;

	# if $n is even:
	return fusc( $n / 2 ) if $n % 2 == 0;

	# if $n is odd:
	my $halfn = ($n-1)/2;
	return fusc($halfn) + fusc($halfn+1);
}


foreach my $n (0..49)
{
	my $f = fusc($n);
	print "$f,";
}
say "";
