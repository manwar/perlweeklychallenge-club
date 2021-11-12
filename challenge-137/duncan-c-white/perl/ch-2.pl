#!/usr/bin/perl
# 
# TASK #2 - Lychrel Number
# 
# You are given a number, 10 <= $n <= 1000.
# 
# Write a script to find out if the given number is Lychrel number;
# output 1 if it is, and zero if it is not.  To keep the task simple, we impose the following rules:
# 
# a. Stop and return 1 if the number of iterations reached 500.
# b. Stop and return 1 if you end up with number >= 10_000_000.
# 
# According to wikipedia:
# 
#     A Lychrel number is a natural number that cannot form a palindrome
#     through the iterative process of repeatedly reversing its digits
#     and adding the resulting numbers.
# 
# Example 1
# 
# 	Input: $n = 56
# 	Output: 0
# 
# 	After 1 iteration, we found palindrome number.
# 	56 + 65 = 121
# 
# Example 2
# 
# 	Input: $n = 57
# 	Output: 0
# 
# 	After 2 iterations, we found palindrome number.
# 	 57 +  75 = 132
# 	132 + 231 = 363
# 
# Example 3
# 
# 	Input: $n = 59
# 	Output: 0
# 
# 	After 3 iterations, we found palindrome number.
# 	 59 +  95 =  154
# 	154 + 451 =  605
# 	605 + 506 = 1111
# 
# MY NOTES: Sounds pretty easy.
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Getopt::Long;
use Data::Dumper;

my $debug = 0;

die "Usage: is-lychrel [-d|--debug] N\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==1;
my $n = shift @ARGV;
die "$n is out of range 10..1000\n" if $n < 10 || $n > 1000;


#
# my @steps = get_to_palindrome( $n );
#	Try to find a sequence of n + reverse(n) values leading to a palindrome,
#	if you find one in less than 500 steps, with no intermediate value
#	exceeding 10,000,000, then return the sequence of steps.
#	If you can't find such a sequence, return ().
#
fun get_to_palindrome( $n )
{
	my @result;
	for( my $nit = 0; $nit<500; $nit++ )
	{
		return () if $n > 10000000;		# intermediate value too big
		my $r = reverse($n);
		my $msg = sprintf( "%4d + %4d = %d", $n, $r, $n+$r );
		push @result, $msg;
		say "debug: $msg" if $debug;
		$n += $r;
		return @result if $n == reverse($n);	# found a palindrome
	}
	return ();					# too many iterations
}


my @seq = get_to_palindrome( $n );
say "Input:  $n";
print "Output: ";
if( @seq )
{
	say 0;
	my $steps = @seq;
	say "\nAfter $steps iterations, we found a palindrome:";
	say for @seq;
} else
{
	say 1;
}
