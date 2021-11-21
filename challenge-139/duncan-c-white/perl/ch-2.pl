#!/usr/bin/perl
# 
# TASK #2 - Long Primes
# 
# Write a script to generate first 5 Long Primes.
# 
# A prime number (p) is called Long Prime if (1/p) has an infinite decimal expansion repeating every (p-1) digits.
# 
# Example
# 
# 	7 is a long prime since 1/7 = 0.142857142857...
# 	The repeating part (142857) size is 6 i.e. one less than the prime number 7.
# 
# 	Also 17 is a long prime since 1/17 = 0.05882352941176470588235294117647...
# 	The repeating part (0588235294117647) size is 16 i.e. one less than the prime number 17.
# 
# 	Another example, 2 is not a long prime as 1/2 = 0.5.
# 	There is no repeating part in this case.
# 
# MY NOTES: Sounds pretty easy.  First generate some primes (have code to do that using Sieve of
#        Erathosthenes).  Then check each prime p to see if 1/p's 2*p long decimal fraction
# 	 repeats after p-1 digits (and doesn't repeat after any shorter digit sequence)
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Getopt::Long;
use Data::Dumper;
use List::Util qw(sum);

use lib qw(.);
use MakePrimes;

my $debug = 0;

die "Usage: first-n-long-primes [-d|--debug] N\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==1;
my $n = shift @ARGV // 5;

my @primes = primes_upto( 20*$n );		# complete guess

#
# my @d = divide1divP( $ndigits, $p );
#	Compute and return the first $ndigits of the 1/$p decimal fraction
#	(purely the 0.ddddddddd part) as an array of digits.
#
fun divide1divP( $ndigits, $p )
{
	my $numer = 1;
	my @d;
	foreach my $i (1..$ndigits)
	{
		$numer *= 10;
		my $x = int($numer/$p);
		#say "debug: numer=$numer, p=$p, digit=$x";
		push @d, $x;
		$numer -= $x*$p;
	}
	return @d;
}


#
# my $repeatN = repeateveryN( $n, @d );
#	Return 1 iff the sequence @d (at least 2*$n elements long)
#	repeats every $n elements; 0 otherwise.
#
fun repeatN( $n, @d )
{
	die "repeatN($n): n<1\n" if $n<1;
	my $l = @d;
	die "repeatN($n): sequence not long enough: length $l"
		unless $l >= 2*$n;

	foreach my $i ($n..$l-1)
	{
		return 0 unless $d[$i%$n] == $d[$i];
	}
	#say "sequence ".join(',',@d)." repeats every $n digits";
	return 1;
}


#
# my $islong = longprime($p);
#	Return 1 iff 1/p's 2*p digit long decimal fraction
#	repeats the same sequence after p-1 digits (and
#	doesn't repeat after any shorter sequence).
#
fun longprime( $p )
{
	say "checking longprime $p" if $debug;
	my @d = divide1divP( 2*$p, $p );
	#say "decimal fraction is @d";

	return 0 unless repeatN( $p-1, @d );	# fail unless it repeats every $p-1 digits
	foreach my $i (1..$p-2)			# fail if it repeats any shorter num digits
	{
		return 0 if repeatN( $i, @d );
	}
	return 1;
}


my @longprimes;
my $l=0;
foreach my $p (@primes)
{
	if( longprime($p) )
	{
		push @longprimes, $p;
		$l = @longprimes;
		say "$p is longprime; length $l" if $debug;
	}
	last if $l==$n;
}
my $len = @longprimes;
say "First $len long primes: @longprimes";
