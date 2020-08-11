#! /opt/local/bin/perl
#
#       prime_decomposition.pl
#
#       prints Prime Decomposition of a given number, given as an argument
#
#
#       2019 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN

my $target = shift @ARGV;
my @decomp = decompose( $target );
say (join ', ', @decomp);

## ## ## ## ## SUBS

sub decompose {
## given a number,
## returns an array list of prime decomposition factors of the number
    my $num = shift;
    my @decomp;
    my $prime = 2;
    my $primelist = [$prime];

    while ( $prime <= $num ) {
        while ($num % $prime == 0) {
            $num = $num / $prime;
            push @decomp, $prime;
        }
        $prime = get_next_prime($primelist);
    }

    return @decomp;

}

sub get_next_prime {
## given a listref of all primes up until a certain point,
## adds next prime to the list and returns the prime

    my $primelist = shift;

    ## assign the last prime recorded + 1 as the new candidate
    my $candidate = $primelist->[scalar $primelist->@* - 1] + 1;

    ## index through the prime list checking for divisability; if found
    ## augment and restart the test.
    ## if the test value exceeds the squareroot of the candidate, the candidate
    ## is prime. Put it on the list and return the candidate.
    ## yes it's an infinite loop but there will always be another prime, right?
    ## right?
    for (my $i = 0; my $test = $primelist->[$i]; $i++) {
        my $root = int(sqrt($candidate));
        if ($test > $root) {
            push $primelist->@*, $candidate;
            return $candidate;
        }

        if ($candidate % $test == 0) {
            $i = -1;
            $candidate++;
            next;
        }
    }

}
