#!/usr/bin/perl

#real	0m12.640s
#user	0m12.507s
#sys	0m0.031s

use Math::Prime::Util::GMP qw(is_prime primes);
use PDL;
use PDL::NiceSlice;
use PDL::AutoLoader;

#-- set some global ("local") constants
local $MAXPRIMES=100_000;
local $primes = pdl (primes ($MAXPRIMES) );

#-- test examples
print &prime_partition(18,2),"\n";
print &prime_partition(19,3),"\n";
print &prime_partition(19,4),"\n";
print &prime_partition(200,3),"\n";
print &prime_partition(200,4),"\n";
print &prime_partition(1000,3),"\n";
print &prime_partition(10000,3),"\n";
print &prime_partition(80000,3),"\n";
print &prime_partition(200,5),"\n";

#-- prime partition sub
sub prime_partition {
	my ($m, $n) = @_;

	($n > (int($m/2)+1)) && (return zeroes($n,0));

	if ($m > $MAXPRIMES) {
		$primes=append($primes,primes($MAXPRIMES,$m));
		$MAXPRIMES=$m;
	} 
	
	my $retval=zeros($n,0); #-- return value	
	
	#-- CASE N==2
	if ($n==2) {
				
		for my $prime ($primes -> list) {				
			if (is_prime ($m - $prime) ) {
				
				$retval = 
				$retval -> glue (1,
					pdl([$prime,$m-$prime]));
			}
			last if ($prime > int($m/2) ); 
		}
		return qsortvec(qsort($retval))->uniqvec;
	}
	
	#-- CASE N > 2 : RECURSION
	if ($n > 2) {
			
		for my $prime ($primes -> list) {
			my $p1 = &prime_partition ($m-$prime, $n-1);
			if ($p1 -> dim(1) > 0) { 
				$p1 = append($prime, $p1);
				$retval = $retval->glue(1, $p1);
			}
			last if ($prime > int($m/$n) );
		}
		return qsortvec(qsort($retval))->uniqvec;
	}
}

