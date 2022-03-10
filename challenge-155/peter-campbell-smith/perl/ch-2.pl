#!/usr/bin/perl

# Peter Campbell Smith - 2022-03-09
# PWC 155 task 2

use v5.28;
use strict;
use warnings;
use utf8;
use Math::Prime::Util 'is_prime';
use Math::BigInt lib => 'GMP';

# Write a script to find the period of the 3rd Pisano Period.

# In number theory, the nth Pisano period, written as π(n), is the period with 
# which the sequence of Fibonacci numbers taken modulo n repeats.

# For any integer n, the sequence of Fibonacci numbers F(i) taken modulo n 
# is periodic. The Pisano period, denoted π(n), is the value of the period of 
# this sequence.

# Blog at https://pjcs-pwc.blogspot.com/2022/03/bigint-week.html

my (@fib, $last_term, $max_period, $n, @n, $pp, $string, $unit, $match, $ls);

$last_term = 5000;   # consider this number of terms in the series
$max_period = 300;    # consider periods up to this length

# velues of n to test (max = 62 - see blog)
@n = (2, 3, 4, 5, 6, 7, 8, 9, 10, 20, 30, 40, 50, 60, 62);   # n's to test (max = 62)

make_fib();   # create Fibonacci series using BigInts

for $n (@n) {                      # testing the nth Pisano period

	# stringify the moduli of the fib series
	$string = make_string($n);
	
	# now look for repeating patterns pp characters long
	for $pp (1 .. $max_period) {
		
		# this is the repating unit
		$unit = substr($string, 0, $pp);
		
		# and this is a repetition of the repeating unit as long as the stringified moduli
		$match = substr($unit x ($last_term / $pp + 1), 0, $last_term + 1);
		
		# and if they match we have a result
		next unless $match eq $string;
		say qq[p($n) = $pp];
		last;
	}
}

sub make_fib {
	
	# this is the usual formula expresed in BigInt-ish
	$fib[0] = Math::BigInt->new(0); 
	$fib[1] = Math::BigInt->new(1); 
	
	for my $j (2 .. $last_term) {
		$fib[$j] = Math::BigInt->new($fib[$j - 1]);
		$fib[$j]->badd($fib[$j - 2]);
	}
}

sub make_string {
	
	# makes a string of symbols where the j'th symbol represents the value mod n
	# of the j'th item in the fibonacci series
	my ($item, $char, $string);
	for my $j (0 .. $last_term) {
		$item = Math::BigInt->new($fib[$j]);   # fib number
		$item->bmod($_[0]);                    # ... modulo n
		$char = substr('01234567890ABCDEFGHIJKLMONPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz', $item, 1);
		$string .= $char;
	}
	return $string;
}		
