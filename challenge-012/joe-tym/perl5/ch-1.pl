#!/usr/bin/perl

use strict;
use warnings;
use PDL;
use Data::Dumper;

=head1 synopsis
	http://blogs.perl.org/users/laurent_r/2019/06/perl-weekly-challenge-12-euclids-numbers-and-directories.html
	
	Refactored to use Perl Data Language(PDL), Perl's numpy equivalent to calculate prime numbers
=cut


main();

sub main {
    my $primes = primesfrom2to(31000);
	print $primes->where($primes > 30000); exit;
    #print is_prime($primes, 13);
	my @prime_numbers = $primes->list();
	print is_prime($primes, 30031);


	for my $i (0..20) {
		my $euclid_1 = 1;
		$euclid_1 *= $prime_numbers[$_] for 0..$i;
		my $euclid = $euclid_1 + 1;
		print Dumper($euclid);
		say $euclid and last unless is_prime($primes, $euclid);   
	}
}

=head1
https://stackoverflow.com/questions/2068372/fastest-way-to-list-all-primes-below-n=head1

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
	my $n = shift || die 'input expected';
	my $sieve = ones($n/3 + ($n % 6 == 2));
	my $end = int($n**0.5)/3+1 - 1;
	my $last = $sieve->dim(0) - 1;
	foreach my $i (1..$end) {
		if ($sieve->at($i) == 1) {
			my $k = 3*$i+1|1;
			my $start1 = $k*$k/3;
			my $start2 = $k*($k-2*($i&1)+4) / 3;
			my $step = 2*$k;
			#print "$k $start1 $start2 $step\n";
			
			#if ($start1 <= $last) {
				$sieve->slice($start1.':'.$last.':'.$step) .= 0;
			#}
			if ($start2 <= $last) {
				$sieve->slice($start2.':'.$last.':'.$step) .= 0;
			}
		}
	}
	
	return pdl(2,3)->append(3*which($sieve == 1)->slice('1:') + 1|1);
}

sub is_prime {
	my $primes = shift;
	my $input = shift || 'die need input';
	#print Dumper($input, $primes->max());
	if ($input > $primes->max()) {
		die 'input is greater than the maximum prime calculated';
	}
	my $results = which($primes == $input);
	if (!$results->isempty()) {
		return 1;
	}
	return 0;
}

