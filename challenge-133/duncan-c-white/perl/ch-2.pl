#!/usr/bin/perl
# 
# TASK #2 - Smith Numbers
# 
# Write a script to generate first 10 Smith Numbers in base 10.
# 
# According to Wikipedia:
# 
# "In number theory, a Smith number is a composite number for which, in
# a given number base, the sum of its digits is equal to the sum of the
# digits in its prime factorization in the given number base."
# 
# MY NOTES: Ok, an example in the Wikipedia clarifies this:
# 
#     4937775 = 3**1 5**2 658371 (prime factors)
#     4 + 9 + 3 + 7 + 7 + 7 + 5 = 42
#     3 x 1 + 5 x 2 + (6 + 5 + 8 + 3 + 7) x 1 = 42 too
# 
# Should be quite straightforward.
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

die "Usage: smith-nos [-d|--debug] [FIRSTN]\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV<2;
my $firstn = shift @ARGV // 10;

my @primes = primes_upto( 2000 );
my %isprime = map { $_ => 1 } @primes;


#
# my @pfact = prime_factors( $n, @primes );
#	Split $n into it's list of one or more prime factors,
#	using @primes to determine prime-ness or not.  Return the list.
#	eg. prime_factors( 332, (2,3,5,7,11,13,17) ) is 2 x 2 x 83, ie (2,2,83)
#
fun prime_factors( $n, @primes )
{
	my $orig = $n;
	#say "debug: pf($n): primes=".join(',',@primes)."\n";
	return ( $n ) if $n<=2;

	my @result;
	foreach my $f (@primes)
	{
		return @result if $f > $n;
		while( $n % $f == 0 )
		{
			push @result, $f;
			$n /= $f;
		}
	}
	die "prime_factors($orig,".join(',',@primes)."): @ end n ($n) should be 1, where result=".
	    join(',',@result)."\n" unless $n == 1;
	return @result;
}

#my @pfact = prime_factors( 2, @primes );
#say "debug pf(2): ". join(',',@pfact);
#
#@pfact = prime_factors( 3, @primes );
#say "debug pf(3): ". join(',',@pfact);
#
#@pfact = prime_factors( 4, @primes );
#say "debug pf(4): ". join(',',@pfact);
#
#@pfact = prime_factors( 332, @primes );
#say "debug pf(332): ". join(',',@pfact);


#
# my $is = is_smith($x);
#	Return true iff $x is a SMITH NUMBER, as described above.
#
fun is_smith( $x )
{
	return 0 if $isprime{$x};

	my @pfact = prime_factors( $x, @primes );
	#die "debug: pf($x) = ".join(',',@pfact);

	my $sumdigits = sum( split(//,$x ) );		# sum of digits
	#say "debug: smth($x): sumdigits=$sumdigits";

	my $sumpf = sum( map { sum( split(//,$_) ) } @pfact );
	#say "debug: smth($x): sumpf=$sumpf";

	return 0 unless $sumdigits == $sumpf;
	return 1;
}


for( my $nfound = 0, my $x = 2; $nfound < $firstn; $x++ )
{
	next unless is_smith($x);
	$nfound++;
	print "$x,";
}
print "\n";
