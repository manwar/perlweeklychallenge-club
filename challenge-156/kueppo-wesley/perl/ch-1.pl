#!/usr/bin/env perl

use strict;
use warnings;

### HELPER
# Find log of $n base 2.
sub log_base2 {
    my $n = shift;
    log($n) / log(2)
}

### HELPER
# Check if $number is prime (1: success, 0: failure).
sub is_prime {
    my ($number, $prime) = (shift, 1);

    $prime = 0 if ($number == 1);
    if ($number > 3) {
        foreach my $i (2..sqrt $number) {
        	if ($number % $i == 0) {
        		$prime = 0;
        		last;
        	}
        }
    }
    return $prime;
}

### MAIN
# List the first $limit penicious numbers.
sub penicious {
    my ($v, $limit) = (3, shift);
    my @found = ();

    while (@found != $limit) {
        my ($fpower, $spower) = (log_base2($v + 1), log_base2($v - 1));
        if ($spower =~ /^\d+$/) {
        	push @found, $v;
        } elsif ($fpower =~ /^\d+$/ and is_prime $fpower) {
        	push @found, $v;
        } else {
        	my ($ones, $val) = (0, sprintf '%b', $v);
        	foreach (split '', $val) {
        		$ones++ if ($_ eq '1');
        	}
        	push @found, $v if (is_prime $ones);
        }
        $v++;
    }
    print join ', ', @found, "\n";
}

penicious 10;
