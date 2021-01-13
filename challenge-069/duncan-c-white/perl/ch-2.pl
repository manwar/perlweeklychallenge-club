#!/usr/bin/perl
#
# Task 2: "0/1 String
#
# A 0/1 string is a string in which every character is either 0 or 1.
# 
# Write a script to generate S30 under the following rules:
# 
# S0 = ""
# S1 = "0"
# S2 = "001"
# S3 = "0010011"
# 
# SN = SN-1 + '0' + switch(reverse(SN-1))
# 
# switch:
#   Every 0 becomes 1 and every 1 becomes 0. For example, '101' becomes '010'.
# 
# reverse:
#   The string is reversed. For example, "001" becomes "100".
# 
# My notes: ok.  Binary strings, defined by a recurrence relation, can be
# computed iteratively. btw, 'switch' means 1s-complement.
#

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Data::Dumper;

die "Usage: binary-switch-reverse N\n" unless @ARGV==1;
my $n = shift;


#
# my $ss = switch($s);
#	Return the string 1-s complement of the binary string $s.
#	eg. switch('001') is '110'.
#
fun switch( $s )
{
	$s =~ tr/01/10/;
	return $s;
}


my $s = "";
foreach my $x (1..$n)
{
	# SN = SN-1 + '0' + switch(reverse(SN-1))
	$s .= '0' . switch(reverse($s));
	#say "s($x) = $s";
}
say "s($n) = $s";
