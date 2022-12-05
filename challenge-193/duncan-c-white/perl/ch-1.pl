#!/usr/bin/perl
# 
# Task 1: Binary String
# 
# You are given an integer, $n > 0.
# Write a script to find all possible binary numbers of size $n bits.
# 
# Example 1
# 
# Input: $n = 2
# Output: 00, 11, 01, 10
# 
# Example 2
# 
# Input: $n = 3
# Output: 000, 001, 010, 100, 111, 110, 101, 011
# 
# MY NOTES: very easy
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-1.pl
# into C (look in the C directory for the translation)
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;

my $debug=0;
die "Usage: binary-strings [--debug] N\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==1;

my $n = shift;
$n += 0;

my $max = 2 ** $n;
#say $max;

my @result;
for( my $i=0; $i<$max; $i++ )
{
	my $bitstring = sprintf( "%0".$n."b", $i );
	push @result, $bitstring;
}
say join(', ', @result );
