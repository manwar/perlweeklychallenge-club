#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       add-another-prime-to-the-pile.pl
#
#       Additive Primes
#         Submitted by: Mohammad S Anwar
# 
#         Write a script to find out all Additive Primes <= 100.
# 
#         Additive primes are prime numbers for which the sum of their
#         decimal digits are also primes.
# 
#         Output
#             2, 3, 5, 7, 11, 23, 29, 41, 43, 47, 61, 67, 83, 89
#             
#         method
# 
#             You know, sometimes when I do these problems I like to
#             pretend that I'm not good at math. Which is to say choose to
#             I regard the problem as a computing problem, rather than a
#             math problem, or or even more broadly a problem in search of
#             a structure that will solve it, rather than any specific
#             answer. 
#             
#             Or put another way solve a more generalized version with more
#             unknowns. 
#             
#             In this problem we need a bunch of prime numbers. A quick bit
#             of mathematical reasoning tells us 
#                 
#                 1. that 100 is not a additive prime, as it adds to 1
#                 2. the that largest digit-sum we'll need to deal with is 
#                    for the value 99, where 9 + 9 = 18. 
#                 3. thus, using preexisting knowledge we only need to consider 
#                    the primes 2, 3, 5, 7, 11, 13, and 17
# 
#             But you know what? We're going to pretend we don't know that,
#             and instead compute as many primes as required. Along the way
#             we'll make the upper limit user-configurable, which will
#             allow us to find the number 102 should we wish, which by the
#             looks of it is an addative prime. 
# 
#             What we'll need to do is make a lookup of primes that
#             contains every prime less than the largest value we have
#             tried to date. The digit sum will always be less than or
#             equal to the value. If we exceed the last prime found, we'll
#             expand our bounds in the list of found primes as required.
# 
#             We can then construct a lookup hash to check for primality.
# 
#             Then we can break apart the number into its digits and sum
#             them, and do a quick lookup to see whether the result is
#             prime. 
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

use List::Util qw( sum0 );

my @primes;
my %lookup;
my @additives;

## make a closed prime iterator function
## modified to add to the prime lookup hash
my $pg =  sub {
    if ( @primes < 2 ) {
        push @primes, @primes == 0 ? 2 : 3;
        $lookup{ $primes[-1] } = 1;
        return $primes[-1];
    }

    my $candidate = $primes[-1] ;
    CANDIDATE: while ( $candidate += 2 ) {
        my $sqrt_candidate = sqrt( $candidate );
        for my $test ( @primes ) {
            next CANDIDATE if $candidate % $test == 0;
            last if $test > $sqrt_candidate;
        }
        push @primes, $candidate;
        $lookup{ $candidate } = 1;
        return $candidate;
    }
} ;
$pg->();        ## init the prime array with 2

my $limit = shift @ARGV // 100;

## look at the numbers 1 to $limit,
## checking each for primality and primality in the digit sum
for ( 1..$limit ) {
    $pg->() if $primes[-1] <= $_ ;
    next unless $lookup{$_} ;
    my $sum = sum0( split //, $_ );
    push @additives, $_ if  $lookup{$sum};
}

say join ', ',  @additives;



 
