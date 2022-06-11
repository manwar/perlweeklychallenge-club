#!/usr/bin/perl
# 
# TASK #1 - Fibonacci Digit Sum
# 
# Given an input $N, generate the first $N numbers for which the sum of
# their digits is a Fibonacci number.
# 
# Example
# 
# f(20)=[0, 1, 2, 3, 5, 8, 10, 11, 12, 14, 17, 20, 21, 23, 26, 30, 32, 35, 41, 44]
# 
# MY NOTES: Pretty easy.  Only question: how many Fibonacci numbers do we
# need to compute?  Let's extend the sequence whenever we need..
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;
use List::Util qw(sum);

my $debug=0;
die "Usage: fib-digit-sum [--debug] [N default 20]\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV<2;
my $n = shift // 20;

# fibonacci numbers we've calculated yet
my @fib = (0, 1);

# fibonacci numbers up to $fib[-1] as a set
my %isfib = map { $_ => 1 } @fib;

my @found;

for( my $x = 0; @found < $n; $x++ )
{
	# form sum of digits of $x
	my $s = sum( split(//,$x) );

	# extend @fib and %isfib if necessary
	while( $s > $fib[-1] )
	{
		say "s=$s, last fib known = $fib[-1], calculating more fibs" if $debug;
		my $next = $fib[-1] + $fib[-2];
		say " calc next fib $next" if $debug;
		push @fib, $next;
		$isfib{$next}++;
	}

	# now use the isfib set to see if $s is a member (given that the above
	# loop guarantees we've calculated isfib up to $s).
	push @found, $x if $isfib{$s};
}

say join(', ', @found);
