#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-04-06
use utf8;     # Week 368 - task 2 - Big and little omega
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

big_and_little_omega(100061, 0);
big_and_little_omega(971088, 0);
big_and_little_omega(63640, 1);
big_and_little_omega(988841, 1);
big_and_little_omega(211529, 0);

sub big_and_little_omega {
	
	my ($number, $mode, $sieve, $p, $count, $explain, $try, $omega);
	
	# initialise
	($number, $mode) = @_;
	
	# loop over primes < $number
	$sieve = make_sieve($number / 2);
	for $p (2 .. $number) {
		next unless $sieve->[$p];
		$try = $number;
		
		# is this prime a factor?
		while (1) {
			$try = $try / $p;
			last unless $try == int($try);
			$explain .= qq[$p, ];
			$count ++;
			
			# repeat unless looking for little omega
			last if ($mode == 0 or $try == 1);
		}
	}
	
	# report
	$explain = substr($explain, 0, -2);	
	$omega = $mode ? 'Ω' : 'ω' ;
	say qq[\nInput:  \$number = $number, \$mode = $mode];
	say qq[Output: $omega = $count ($explain)];
}

sub make_sieve {  # of Eratosthenes

    my ($arg, $j, $k, @sieve);
    
    # set all values provisionally to 1 (ie prime)
    $arg = shift;
    for $j (0 .. $arg) {
        $sieve[$j] = 1;
    }

    # for each prime in turn, set its multiples to 0 (ie not prime)
    for $j (2 .. $arg) {
        next unless $sieve[$j];   # $j is not prime
        last if $j ** 2 > $arg;
        for $k ($j .. $arg) {
            last if $k * $j > $arg;
            $sieve[$k * $j] = 0;
        }
    }
	return \@sieve;
}
