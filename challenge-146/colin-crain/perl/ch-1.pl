#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       ten-thousand-and-one-nights.pl
#
#       10001st Prime Number
#         Submitted by: Mohammad S Anwar
#         Write a script to generate the 10001st prime number
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';


say make_primes_quantity( 10001 )->[-1];


sub make_primes_quantity ( $quantity ) {
## creates a list of the first $quantity primes
    my ($candidate, @primes) = ( 1, 2 );

    CANDIDATE: while ( $candidate += 2 and @primes < $quantity ) {
        my $sqrt_candidate = sqrt( $candidate );
        for my $test ( @primes ) {
            next CANDIDATE if $candidate % $test == 0;
            last if $test > $sqrt_candidate;
        }
        push @primes, $candidate;
    }
    return \@primes;
}

