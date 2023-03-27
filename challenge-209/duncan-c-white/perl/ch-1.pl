#!/usr/bin/perl
# 
# Task 1: Special Bit Characters
# 
# You are given an array of binary bits that ends with 0.
# 
# Valid sequences in the bit string are:
# 
# [0] -decodes-to-> "a"
# [1, 0] -> "b"
# [1, 1] -> "c"
# 
# Write a script to print 1 if the last character is an 'a' otherwise
# print 0.
# 
# Example 1
# 
#   Input: @bits = (1, 0, 0)
#   Output: 1
# 
#   The given array bits can be decoded as 2-bits character (10) followed
#   by 1-bit character (0).
# 
# Example 2
# 
#   Input: @bits = (1, 1, 1, 0)
#   Output: 0
# 
#   Possible decode can be 2-bits character (11) followed by 2-bits
#   character (10) i.e. the last character is not 1-bit character.
# 
# MY NOTES: very easy.  decode string then check last letter of decoded version.
# I wonder if there's a way of decoding-and-checking together, though.
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-1.pl into C
# (look in the C directory for that).
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;

my $debug=0;
die "Usage: spc [--debug] list-of-bits\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==1;

my $bits = shift;
die "bad bit $1 in $bits\n" if $bits =~ /([^01])/;

say "bits: $bits" if $debug;

# decode
while( $bits =~ s/10/b/ || $bits =~ s/11/c/ || $bits =~ s/0/a/ )
{
}

say "decoded bits: $bits" if $debug;

say $bits =~ /a$/ ? 1 : 0;
