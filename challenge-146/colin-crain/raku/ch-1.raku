#!/usr/bin/env perl6
#
#
#       ten-thousand-and-one-nights.raku
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ( $nth = 10001, $slow = Nil ) ;

## we could do this but it's s-l-o-w 
## so we won't.
defined $slow and do {
    last unless defined $slow;
    my @primes = grep { .is-prime }, 1..* ;
    say @primes[ $nth ] ;
}

## so instead we do this, and 
## eliminate large swaths of useless searching

nth-prime( $nth ).say;

sub nth-prime ( $nth ) {
## creates a list of the first $quantity primes
    my ($candidate, @primes) = 1, 2 ;
    CANDIDATE: while ( $candidate += 2 and @primes.elems < $nth ) {
        my $sqrt_candidate = sqrt( $candidate );
        for @primes -> $test {
            next CANDIDATE if $candidate %% $test ;
            last if $test > $sqrt_candidate;
        }
        @primes.push: $candidate;
    }
    return @primes[*-1];
}
