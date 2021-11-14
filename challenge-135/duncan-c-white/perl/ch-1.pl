#!/usr/bin/perl
# 
# TASK #1 - Middle 3-digits
# 
# You are given an integer.
# 
# Write a script find out the middle 3-digits of the given integer, if
# possible otherwise throw sensible error.
# 
# Example 1
# 
#   Input: $n = 1234567
#   Output: 345
# 
# Example 2
# 
#   Input: $n = -123
#   Output: 123
# 
# Example 3
# 
#   Input: $n = 1
#   Output: too short
# 
# Example 4
# 
#   Input: $n = 10
#   Output: even number of digits
# 
# MY NOTES: Pretty easy, although it's not clear how to always treat negative numbers.
# Assume abs() them.
#

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
#use Data::Dumper;


my $debug=0;
die "Usage: middle-3-digits N\n" unless
	GetOptions( "debug"=>\$debug ) && @ARGV==1;
my $n = shift @ARGV;
$n = abs($n);

my $l = length($n);
die "$n too short\n" if $l<3;

die "even number of digits\n" if ($l&1)==0;

my $midpos = int($l/2);

say substr($n,$midpos-1,3);
