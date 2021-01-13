#!/usr/bin/perl
#
# Task 1: "Excel Column
# 
# Write a script that accepts a number and returns the Excel Column Name
# it represents and vice-versa.
# 
# Excel columns start at A and increase lexicographically using the 26
# letters of the English alphabet, A..Z. After Z, the columns pick up an
# extra letter, going from AA, AB, etc., which could (in theory)
# continue to an arbitrary number of digits. In practice, Excel sheets
# are limited to 16,384 columns.
# 
# Example
# 
# Input Number: 28
# Output: AB
# 
# Input Column Name: AD
# Output: 30
# "
# 
# My notes: very straightforward.
#

use strict;
use warnings;
use feature 'say';


die "Usage: excel-column N\n" unless @ARGV==1;
my $n = shift;
die "excel-column: N should be 1..16384\n" unless $n>0 && $n<=16384;

my $str = "";
while( $n > 26 )
{
	my $digit = 1 + ($n-1) % 26;
	$str .= chr(ord('@')+$digit);
	$n = int( ($n-1) / 26 );
}
$str .= chr(ord('@')+$n);
say scalar reverse $str;
