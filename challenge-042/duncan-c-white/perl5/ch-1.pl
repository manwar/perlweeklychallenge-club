#!/usr/bin/perl
#
# Task 1: "Octal Number System
# 
# Write a script to print decimal number 0 to 50 in Octal Number System.
# 
# For example:
# Decimal 0 = Octal 0
# Decimal 1 = Octal 1
# Decimal 2 = Octal 2
# Decimal 3 = Octal 3
# Decimal 4 = Octal 4
# Decimal 5 = Octal 5
# Decimal 6 = Octal 6
# Decimal 7 = Octal 7
# Decimal 8 = Octal 10
# 
# and so on.
# "
# 
# My notes: Trivial.
# 

use v5.10;	# to get "say"
use strict;
use warnings;

die "Usage: ch-1.pl [N//50]\n" if @ARGV>1;

my $n = shift // 50;

#
# my $o = to_oct_str( $x );
#	Convert x to an octal string, eg. 8 is "10"
#
sub to_oct_str
{
	my( $x ) = @_;
	my $result = "";
	if( $x > 7 )
	{
		$result = to_oct_str( $x>>3 );
	}
	$result .= $x&7;
	return $result;
}


foreach my $x (0..$n)
{
	# convert x to octal..
	my $o = to_oct_str( $x );
	say "$x\t$o";
}

