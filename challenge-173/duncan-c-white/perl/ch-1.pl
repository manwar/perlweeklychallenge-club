#!/usr/bin/perl
# 
# Task 1: Esthetic Number
# 
# You are given a positive integer, $n.
# 
# Write a script to find out if the given number is Esthetic Number.
# 
# An esthetic number is a positive integer where every adjacent digit
# differs from its neighbour by +-1.
# 
# For example,
# 
# 5456 is an esthetic number as |5 - 4| = |4 - 5| = |5 - 6| = 1
# 120 is not an esthetic numner as |2 - 0| != 1
# 
# MY NOTES: ok, sounds quite easy.  Let's make it slightly harder by allowing
# ourselves (in debug mode) to reproduce the examples as written.. although
# note that I've cheated slighltly: I've simplified the "not" output format
# above to show only the first "|a-b| != 1", because it's not quite clear
# what the output should be in all cases.
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-1.pl
# into C (look in the C directory for that).
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;


my $debug=0;
die "Usage: esthetic-number [--debug] N\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==1;
my $n = shift;

#
# my( $isesth, $mesg ) = is_esthetic( $n );
#	Determine whether $n is esthetic, returning a pair
#	($isesth, $mesg).  $isesth is the boolean answer to the
#	question "is it esthetic?", and $mesg is a printable
#	explanation of why - or why not - in the above format.
#	|5 - 4| = |4 - 5| = |5 - 6| = 1
#	or |2 - 0| != 1
#
sub is_esthetic
{
	my( $n ) = @_;

	return (0, "because no single digit is") if $n<10;

	# let's form a list of [prevdig, nextdig, diff] triples
	my @dig = split( //, $n );
	my @trips = map {
		my $a = $dig[$_];
		my $b = $dig[$_+1];
		[ $a, $b, abs($a-$b) ]
	} 0..$#dig-1;

	#die Dumper \@trips;
	my @not1 = grep { $trips[$_][2] != 1 } 0..$#trips;
	#die Dumper \@not1;

	if( @not1 )
	{
		my $not = $trips[shift @not1];
		my( $a, $b, $diff ) = @$not;
		return ( 0, "|$a - $b| != 1" );
	}

	my $mesg = join( " = ", map {
		my $not = $trips[$_];
		my( $a, $b, $diff ) = @$not;
		"|$a - $b|"
	} 0..$#trips ) . " = 1";
	return ( 1, $mesg );
}


my( $isesth, $mesg ) = is_esthetic( $n );
if( $debug )
{
	my $not = $isesth ? "": " not";
	say "$n is$not an esthetic number as $mesg";
} else
{
	say $isesth ? "yes" : "no";
}
