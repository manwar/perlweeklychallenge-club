#!/usr/bin/perl

use Math::Prime::Util::GMP qw(primes is_prime);
use PDL;
use PDL::NiceSlice;
use PDL::AutoLoader;

#-- global parameters
local $MAXPRIMES = 100_000;
local $primes = pdl primes($MAXPRIMES);

print &prime_partition(18,2),"\n";
print &prime_partition(19,3),"\n";
print &prime_partition(20,4),"\n";

sub prime_partition {
	my ($m, $n)=@_;

	if ($m > $MAXPRIMES) {
		$primes = $primes -> append(primes($MAXPRIMES, $m));
		$MAXPRIMES = $m;
	}

	if ($n > $m/2) { return zeros($n,0); }

	my $retval=zeros($n,0);

	#-- $n == 2
	if ($n==2) {
		for my $prime ($primes -> list) {
			if (is_prime($m - $prime)) {
				$retval = $retval->glue(1,
					pdl([$m - $prime, $prime]));
			}
			last unless ($m % 2 ==0); #-- for odd m, m-i will be even for all i>2
			last if ($prime > int($m / 2));
		}
	}

	#-- $n > 2: recursion
	if ($n > 2) {
		for my $prime ($primes -> list) {
			my $p1 = &prime_partition($m - $prime, $n - 1);
			if ( ($p1 -> dim(1)) > 0){
				$p1=append($prime, $p1);
				$retval = $retval->glue(1,$p1);
			}
			last if ($prime > int($m / $n));
		}
	}
	return qsortvec(qsort($retval))->uniqvec;
}

