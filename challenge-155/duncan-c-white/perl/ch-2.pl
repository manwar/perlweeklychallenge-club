#!/usr/bin/perl
# 
# TASK #2 - Pisano Period
# 
# Write a script to find the period of the 3rd Pisano Period.
# 
# In number theory, the nth Pisano period, written as pi(n), is the period
# with which the sequence of Fibonacci numbers taken modulo n repeats.
# 
# The Fibonacci numbers are the numbers in the integer sequence:
# 
# 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584, 4181, 6765, ...
# 
# For any integer n, the sequence of Fibonacci numbers F(i) taken modulo
# n is periodic. The Pisano period, denoted pi(n), is the value of the
# period of this sequence. For example, the sequence of Fibonacci numbers
# modulo 3 begins:
# 
# 0, 1, 1, 2, 0, 2, 2, 1,
# 0, 1, 1, 2, 0, 2, 2, 1,
# 0, 1, 1, 2, 0, 2, 2, 1, ...
# 
# This sequence has period 8, so pi(3) = 8.
# 
# MY NOTES: ok.  Once we've found a sequence of length L that immediately
# repeats, i.e. that the first 2L entries comprise the same length L sequence
# repeated twice, How do we know that this sequence repeats forever?
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
#use Data::Dumper;

my $debug=0;
die "Usage: pisano-period [--debug] [N (default 3)]\n" unless
	GetOptions( "debug" => \$debug ) && @ARGV<2;
my $n = shift // 3;
die "pp: n ($n) must be > 1\n" if $n<2;

#
# my $l = fib_modn_repeat( $n );
#	Compute terms from the Fibonacci sequence mod $n,
#	until the sequence repeats; return the length of
#	the repeated sequence.
#
fun fib_modn_repeat( $n )
{
	my $a = 0;
	my $b = 1;
	say "debug: 0, mod$n 0" if $debug;
	say "debug: 1, mod$n 1" if $debug;

	my @x = ($a, $b);

	for(;;)
	{
		( $a, $b ) =  ( $b, $a+$b );
		say "debug: $b, mod$n ".($b % $n) if $debug;
		push @x, $b%$n;
		my $l = @x;
		if( $l % 2 == 0 )
		{
			$l /= 2;
			my $firsthalf = join(',', @x[0..$l-1]);
			my $secondhalf = join(',', @x[$l..$#x]);
			say "debug: first $firsthalf, second $secondhalf" if $debug;
			next unless $firsthalf eq $secondhalf;
			say "found repeat $firsthalf and $secondhalf, length $l" if $debug;
			return $l;
		}
	}
}

my $l = fib_modn_repeat( $n );
say $l;
