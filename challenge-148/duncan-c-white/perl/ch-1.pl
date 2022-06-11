#!/usr/bin/perl
# 
# TASK #1 - Eban Numbers
# 
# Write a script to generate all Eban Numbers <= 100.
# 
# An Eban number is a number that has no letter 'e' in it when the
# number is spelled in English (American or British).
# 
# Example
# 
# 2, 4, 6, 30, 32 are the first 5 Eban numbers.
# 
# MY NOTES: Very easy, no doubt there are CPAN modules to "speak" numbers
# in English, but let's do it from first principles..
#

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;

my $debug=0;
die "Usage: twodigit-eban-numbers [--debug]\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==0;

my @digits = qw(zero one two three four five six seven eight nine);
my @tens = qw(ten twenty thirty forty fifty sixty seventy eighty ninety);

#
# my $english = convert_to_english( $n );
#	Convert the two digit $n (n<100) to English form, eg 33->"thirty-three"
#
sub convert_to_english ($)
{
	my( $n ) = @_;

	die "convert_to_english: $n out of range 0..99\n" if $n<0 || $n>99;

	my $d = $n%10;
	my $dig = $digits[$d];
	$n = int($n/10);
	return $dig if $n==0;

	my $tens = $tens[$n-1];
	return $tens if $d==0;
	return $tens.'-'.$dig;
}


#
# my $iseben = is_eben_2digit($n);
#	Return 1 iff the two digit $n (n<100) is an Eben
#	number, 0 otherwise.
#
sub is_eben_2digit ($)
{
	my( $n ) = @_;

	my $english = convert_to_english( $n );

	# Eben iff english form contains an 'e'..
	# "? 1 : 0" is just in case we want to print the return
	# value during debugging (otherwise false would be undef)
	my $eb = $english !~ /e/ ? 1 : 0;

	say "$n is eben (cos english is $english)" if $debug && $eb;

	return $eb;
}


say join( ',', grep { is_eben_2digit($_) } 1..99 );
