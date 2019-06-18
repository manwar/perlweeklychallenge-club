#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;
use List::Util qw(product);

=head1 synopsis
	http://blogs.perl.org/users/laurent_r/2019/06/perl-weekly-challenge-12-euclids-numbers-and-directories.html
	
	Refactored to use Perl Data Language(PDL), Perl's numpy equivalent, to calculate prime numbers

	Benchmark results, full solution:

	PDL Only                    -> 0m0.340s
	Math::Prime::FastSieve+PDL  -> 0m0.337s
	Math::Prime::FastSieve Only -> 0m0.188s

	Benchmark results, just to generate prime numbers 0-10 million:

	Pure Perl implementation(above) -> 0m26.662s
	PDL implementation(below)       -> 0m0.284s
	NUMPY(1.8.2) implementation:    -> 0m0.129s
	Math::Prime::FastSieve          -> 0m0.122s
	
	Perl script that does nothing, just use PDL;        -> 0m0.132s 
	Python script that does nothing, just import numpy; -> 0m0.066s
=cut


main();

sub main {
	my $n = 10000000;
	#pdl_version($n);
	math_prime_fastsieve($n);
}

sub pdl_version {
	my $n = shift || die 'need input';
	use PDL;
	my $primes = primesfrom2to($n);
	my $last_prime_index = $primes->dim(0) - 1;

	for my $i (0..$last_prime_index) {
		my $euclid = $primes->slice("0:$i")->prodover() + 1;
		
		if (!is_prime($primes, $euclid)) {
			print $euclid."\n";
		}
	}
}

sub math_prime_fastsieve {
	my $n = shift || die 'need input';
	use Math::Prime::FastSieve qw(primes);
	my $sieve = Math::Prime::FastSieve::Sieve->new($n);
	my $last_prime_index = $sieve->count_sieve();
	my $largest = $sieve->nth_prime($last_prime_index);	

	for my $i (1..$last_prime_index) {
		my @values = map { $sieve->nth_prime($_) } (1..$i);
		my $euclid = product(@values) + 1;
		#print Dumper(\@values, $euclid);
		#<STDIN>;
		
		if ($euclid > $largest) {
			die 'greater than largest prime calculated ending';
		}
		if (!$sieve->is_prime($euclid)) {
			print $euclid."\n";
		}
	}
}


=head1
https://stackoverflow.com/questions/2068372/fastest-way-to-list-all-primes-below-n

import numpy
def primesfrom2to(n):
    """ Input n>=6, Returns a array of primes, 2 <= p < n """
    sieve = numpy.ones(n//3 + (n%6==2), dtype=numpy.bool)
    for i in range(1,int(n**0.5)//3+1):
        if sieve[i]:
            k=3*i+1|1
            sieve[       k*k//3     ::2*k] = False
            sieve[k*(k-2*(i&1)+4)//3::2*k] = False
    return numpy.r_[2,3,((3*numpy.nonzero(sieve)[0][1:]+1)|1)]
=cut

sub primesfrom2to {
	use integer;
	#my $x = 11 / 3;
	#print Dumper($x); exit;	
	my $n = shift || die 'input expected';
	my $size = $n/3 + ($n % 6 == 2);
	my $last = $size - 1;
	my $sieve = ones($size);
	my $end = int($n**0.5)/3+1;

	#my $sieve_true = $sieve->where($sieve == 1);

	foreach my $i (1..$end) {
		#print $sieve_true->dim(0)."\n";
		#print $sieve_true;
		#print $sieve;
		#$sieve_true .= 0;
		#print Dumper($i);
		if ($sieve->at($i) == 1) {
			my $k = 3*$i+1|1;
			my $start1 = $k*$k/3;
			my $start2 = $k*($k-2*($i&1)+4) / 3;
			my $step = 2*$k;
			#print "$k $start1 $start2 $step\n";
			
			if ($start1 <= $last) {
			#eval {
				$sieve->slice($start1.':'.$last.':'.$step) .= 0;
			}
			if ($start2 <= $last) {
			#eval {
				$sieve->slice($start2.':'.$last.':'.$step) .= 0;
			#};
			}
		}
	}
	#return $sieve;
	#return 1;
	#return 3*which($sieve == 1)->slice('1:') + 1|1;
	# takes ~0.1s vs ~0.04s numpy
	return pdl(2,3)->append(3*which($sieve == 1)->slice('1:') + 1|1);
}

sub is_prime {
	my $primes = shift;
	my $input = shift || die 'need input';
	#print Dumper($input, $primes->max());
	if ($input > $primes->max()) {
		die "input $input is greater than the maximum prime calculated ".$primes->max();
	}
	my $results = which($primes == $input);
	if (!$results->isempty()) {
		return 1;
	}
	return 0;
}

