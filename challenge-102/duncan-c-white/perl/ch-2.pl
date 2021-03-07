#!/usr/bin/perl
# 
# Task 2: "Hash-counting String
# 
# You are given a positive integer $N.
# 
# Write a script to produce Hash-counting string of that length.
# 
# The definition of a hash-counting string is as follows:
# 
# - the string consists only of digits 0-9 and hashes, '#'
# - there are no two consecutive hashes: '##' does not appear in your string
# - the last character is a hash
# - the number immediately preceding each hash (if it exists) is the position
#   # of that hash in the string, with the position being counted up from 1
# 
# It can be shown that for every positive integer N there is exactly one
# such length-N string.
# 
# Examples:
# 
# 	(a) "#" is the counting string of length 1
# 	(b) "2#" is the counting string of length 2
# 	(c) "#3#" is the string of length 3
# 	(d) "#3#5#7#10#" is the string of length 10
# 	(e) "2#4#6#8#11#14#" is the string of length 14
# "
# 
# My notes: ok, weird.  Can we directly generate the single
# hash-counting-string of length N?  I think we can..
# Start from the end: last ch = '#'.  is string long enough?  if not,
# "N#" is how string ends.  is string long enough now? if not, "#N#"
# is how string ends. is string long enough now? if not, N1 = N-2
# prepend N1.. etc.  Turns out to be very easy..
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Getopt::Long;
use Data::Dumper;

my $test=0;
die "Usage: hash-counting-string N\n" unless
	GetOptions( "test" => \$test ) && @ARGV==1;

#
# my $hcs = hcs( $n );
#	Generate the hash-counting-string of length $n.
#
fun hcs( $n )
{
	my $str = '';
	for(;;)
	{
		$str = "#$str" if $n>0;
	return $str if $n==1;
		$str = "$n$str" if $n>0;
	return $str if $n==2;
		my $l = length($n)+1;
		$n -= $l;
	}
}


if( $test )
{
	eval "use Test::More"; die $@ if $@;

	foreach my $n (1..100)
	{
		my $hcs = hcs( $n );
		my $l = length($hcs);
		#say "testing len(hcs($n))=$n";
		is( $l, $n, "len(hash-counting-string($n))==$n" );
	}
	done_testing();
	exit 0;
}

my $n = shift;
my $hcs = hcs( $n );
say "hash-counting-string(length $n) = $hcs";
say "len(hcs) = ".length($hcs);
