#!/usr/bin/perl
#
# Task 1: "Isomorphic Strings
# 
# You are given two strings $A and $B.
# 
# Write a script to check if the given strings are Isomorphic. Print 1 if they are otherwise 0.
# (Isomorphic means: same length, and with a 1-1 mapping between distinct chars in $A and those in $B).
# 
# Example 1:
# 
# 	Input: $A = "abc"; $B = "xyz"
# 	Output: 1
# 
# Example 2:
# 
# 	Input: $A = "abb"; $B = "xyy"
# 	Output: 1
# 
# Example 3:
# 
# 	Input: $A = "sum"; $B = "add"
# 	Output: 0
# "
# 
# My notes: nice!
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
use Data::Dumper;

my $debug = 0;
die "Usage: isomorphic-strings [--debug] A B\n" unless
	GetOptions( "debug" => \$debug ) &&
	@ARGV==2;
my( $a, $b ) = @ARGV;

#
# my $isiso = isomorphic( $a, $b );
#	Determine whether strings $a and $b are isomorphic;
#	return 1 iff they are, 0 otherwise.
#
fun isomorphic( $a, $b )
{
	my $l = length($a);
	return 0 unless $l == length($b);

	my %atob;	# mapping of char from $a to equivalent char in $b
	my %btoa;	# mapping of char from $b to equivalent char in $a
	foreach my $pos (0..$l-1)
	{
		my $ach = substr($a,$pos,1);
		my $bch = substr($b,$pos,1);
		if( defined $atob{$ach} )
		{
			return 0 unless $atob{$ach} eq $bch;
		} else
		{
			return 0 if defined $btoa{$bch};
			$atob{$ach} = $bch;
			$btoa{$bch} = $ach;
		}
	}
	return 1;
}


my $isiso = isomorphic( $a, $b );
say $isiso;
