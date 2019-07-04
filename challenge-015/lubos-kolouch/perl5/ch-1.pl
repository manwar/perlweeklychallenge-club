#!/usr/bin/perl 
#===============================================================================
#
#         FILE: 2019_15_1.pl
#
#        USAGE: ./2019_15_1.pl
#
#  DESCRIPTION: Perl Weekly challenge w15 #1
#               Write a script to generate first 10 strong and weak prime numbers.
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Lubos Kolouch
# ORGANIZATION:
#      VERSION: 1.0
#      CREATED: 07/02/2019 09:47:38 PM
#     REVISION: ---
#===============================================================================

use warnings;
use strict;
use feature qw{ say };

my @strong_primes;
my @weak_primes;

# let's remember the previous and the next primes
# it's not necessary to remember all of them

my $last_prime =2;
my $current_prime;
my $next_prime;

# simple prime check
sub is_prime {
    my $candidate = shift;

    for my $n ( 2 .. int( sqrt($candidate) ) ) {

        # if can be divided, no luck...
        return 0 if ( $candidate % $n == 0 );
    }

    #cool, a prime!
    return 1;
}

my $n = 2;
while (1)
{
    $n++;

    next unless is_prime($n);

    # first run is like:
    # last - 2 current - ? next - ?

    unless ($current_prime) {
        $current_prime = $n;
        next;
    }

    # next runs are like :
    # last - 2 current - 3 next - ?
    # we need last - 2 current - 3 next - 5
    # let's assign next prime and test the current one
    $next_prime = $n;

    push @strong_primes, $current_prime if $current_prime > ($last_prime + $next_prime)/2 and scalar @strong_primes < 10;
    push @weak_primes, $current_prime if $current_prime < ($last_prime + $next_prime)/2 and scalar @weak_primes < 10;

    # ok now let's shift to
    # last - 3 current - 5
    $last_prime = $current_prime;
    $current_prime = $n;

    last if (scalar @strong_primes > 9) and (scalar @weak_primes > 9);
}

say 'Strong primes: '. join ',', @strong_primes;
say 'Weak primes: '. join ',', @weak_primes;


use Test::More;

is( is_prime(5), 1, 'test if prime 1' );
is( is_prime(4), 0, 'test if prime 4');

done_testing();
