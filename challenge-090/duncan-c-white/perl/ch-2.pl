#!/usr/bin/perl
#
# Task 2: "Ethiopian Multiplication
# 
# You are given two positive numbers $A and $B.
# 
# Write a script to demonstrate
#   https://rosettacode.org/wiki/Ethiopian_multiplication
# using the given numbers.
# "
# 
# My notes: clearly defined, once you follow the link and discover what Ethiopian Multiplication is:-)
# Exercise for the interested reader: why does the method work?  It follows directly from how BINARY
# multiplication actually works.
#

use strict;
use warnings;
use Data::Dumper;
use Function::Parameters;
use feature 'say';
use Getopt::Long;

my $debug = 0;
die "Usage: ethiopian-multiplication [--debug] A B\n" unless
	GetOptions( "debug" => \$debug ) &&
	@ARGV==2;
my( $a, $b ) = @ARGV;

say ethiopian( $a, $b );


#
# my $m = ethiopian( $a, $b );
#	Use Ethiopian Multiplication - the original Egyptian/Ethiopian/Russian
#	form of multiplication using repeated doublings and halvings.
#
fun ethiopian( $a, $b )
{
	my $r = 0;
	while( $a >= 1 )
	{
		say "r:$r, a:$a, b:$b" if $debug;
		$r += $b if $a % 2 == 1;
		$a /= 2; $a = int($a);
		$b *= 2;
	}
	say "r:$r, a:$a, b:$b" if $debug;
	return $r;
}
