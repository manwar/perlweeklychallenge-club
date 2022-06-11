#!/usr/bin/perl
# 
# TASK #1 - Pernicious Numbers
# 
# Write a script to permute first 10 Pernicious Numbers.
# 
# A pernicious number is a positive integer which has prime number of ones
# in its binary representation.
# 
# The first pernicious number is 3 since binary representation of 3 =
# (11) and 1 + 1 = 2, which is a prime.
# 
# Expected Output
# 
# 3, 5, 6, 7, 9, 10, 11, 12, 13, 14
# 
# MY NOTES: ok.  Pretty easy.  pernicious(n) = isprime(countones(binary(n)))
# 

use strict;
use warnings;
use feature 'say';
#use bigint;
use Function::Parameters;
use Getopt::Long;
#use Data::Dumper;

#use lib qw(.);
#use MakePrimes;

my $debug=0;
die "Usage: first-n-pernicious [--debug] [N default 10]\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV<2;
my $n = shift // 10;


my %isprime;		# values we've tested and found to be prime
my %tested;		# values we've tested - whether or not they're prime

$tested{1} = 1;
$isprime{1} = 0;

#
# my $isprime = isprime( $x );
#	Return 1 iff $x is prime.  Memoize the ones we know.
#
fun isprime( $x )
{
	return $isprime{$x} if $tested{$x};

	$tested{$x}++;
	$isprime{$x} = 0;
	my $lim = int(sqrt($x));
	for( my $i=2; $i<=$lim; $i++ )
	{
		return 0 if $x % $i == 0;
	}
	$isprime{$x} = 1;
	return 1;
}


#
# my $nones = num_ones_binary( $x );
#	Convert $x to a binary string, count the number of "1" bits
#	in that string, and return the total.  eg num_ones_binary(11) = 3
#	(because binary(11) = 1011, containing 3 ones)
#
fun num_ones_binary( $x )
{
	my @x = split( //, sprintf( "%b", $x ) );
	#say "n_o_b($x): ". join(',',@x);
	my $n = grep { $_ == 1 } @x;
	#say "n_o_b($x): result $n";
	return $n;
}


my @pern;

for( my $i = 3; @pern<$n; $i++ )
{
	my $nones = num_ones_binary($i);
	push @pern, $i if isprime($nones);
}

say join(',', @pern);
