#!/usr/bin/env perl

=head1 SYNOPSIS

Task:
Create a script that prints Prime Decomposition of a given number. The prime decomposition of a number is 
defined as a list of prime numbers which when all multiplied together, are equal to that number. For example, 
the Prime decomposition of 228 is 2,2,3,19 as 228 = 2 * 2 * 3 * 19.

Usage:
    $ perl ch-2.pl 228

Notes:
I used the algorithm described here: https://www.geeksforgeeks.org/print-all-prime-factors-of-a-given-number/ 

=cut

use strict;
use warnings;
use feature 'say';

my $num = $ARGV[0] // '';
die "Must pass an integer > 0 as the first argument\n" unless $num && $num =~ /^\d+$/;

say $num == 1
    ? "No prime factors for 1"
    : join(', ', prime_factors( $num ) )
;

exit 0;

sub prime_factors {
    my $n = shift;

    my @factors;
    while ( $n % 2 == 0 ) {
        push @factors, 2;
        $n /= 2;
    }
    for ( my $i = 3; $i <= sqrt($n); $i += 2 ) {
        while ( $n % $i == 0 ) {
            push @factors, $i;
            $n /= $i;
        }
    }
    push @factors, $n if $n > 2;

    return @factors;
}

