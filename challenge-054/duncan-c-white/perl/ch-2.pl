#!/usr/bin/perl
#
# Task 2: "Collatz Conjecture
#
# It is thought that the following sequence will always reach 1:
# 
#     $n = $n / 2 when $n is even
#     $n = 3*$n + 1 when $n is odd
# 
# For example, if we start at 23, we get the following sequence:
# 
# 	23 -> 70 -> 35 -> 106 -> 53 -> 160 -> 80 -> 40 -> 20 -> 10 -> 5 -> 16 -> 8 -> 4 -> 2 -> 1
# 
# Write a function that finds the Collatz sequence for any positive
# integer. Notice how the sequence itself may go far above the
# original starting number.
# 
# Extra Credit
# 
# Have your script calculate the sequence length for all starting numbers
# up to 1000000 (1e6), and output the starting number and sequence length
# for the longest 20 sequences."
# 
# My notes: Sounds interesting!
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Data::Dumper;


die "Usage: collatz N(>0) or -N [meaning do for all N=1..10^6]\n"
	unless @ARGV==1;
my $n = shift;

if( $n>0 )
{
	my @seq = collatz( $n );
	say "collatz $n = ", join(',', @seq);
} else
{
	# find longest 20 sequences for x=1..n
	my @longest20;	# array of [ len, sequence ]

	foreach my $x (1..-$n)
	{
		my @seq = collatz( $x );
		my $len = @seq;
		push @longest20, [ $len, @seq ];
		@longest20 = sort { $b->[0] <=> $a->[0] } @longest20;
		$#longest20 = 19 if @longest20>20;
		#say "x=$x longest: ", join(',',@$_) for @longest20;
	}

	say "longest 20 collatz sequences:";
	foreach my $longest (@longest20)
	{
		my( $len, @seq ) = @$longest;
		say "len=$len: ", join(',',@seq);
	}
}


#
# my @seq = collatz( $n );
#	Generate the collatz sequence for $n.
#	Rules are:
#		stop when $n==1
#		$n = $n / 2 when $n is even
#		$n = 3*$n + 1 when $n is odd
# 
#
fun collatz( $n )
{
	my @seq = ( $n );
	while( $n != 1 )
	{
		if( $n%2==0 ) { $n = $n / 2 } else { $n = 3*$n + 1 }
		push @seq, $n;
	}
	return @seq;
}
