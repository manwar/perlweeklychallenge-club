#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       squarefree-is-only-one-side-of-the-story.pl
#
#       Moebius Number
#         Submitted by: Mohammad S Anwar
#         You are given a positive number $n.
# 
#         Write a script to generate the Moebius Number for the given
#         number. Please refer to wikipedia page for more informations.
# 
#         Example 1:
#             Input: $n = 5
#             Output: -1
#     
#         Example 2:
#             Input: $n = 10
#             Output: 1
#     
#         Example 3:
#             Input: $n = 20
#             Output: 0
# 
#         method:
# 
#             Named after August Ferdinand Möbius, of mongonal strip fame,
#             the Möbius function serves as a classifier
#             for number factorization: whether a number is squarefree,
#             and, if so, whether is has an odd or even number of prime
#             factors.
# 
#             The squarefree numbers, that we visited in PWC150, are
#             numbers whose prime decompositions have no squared values.
#             This in turn leads to the conclusion  that the list of prime
#             factors contains only unique values, as any factor repeated more
#             than two times also contains the second power within that
#             higher exponent. What we are left with is that the only remaining
#             permissible exponent is 1.
# 
#             If a number is not squarefree it in given the Möbius number
#             0.
# 
#             If the number is 1 it is given the Möbius number 1.
# 
#             If the number is squarefree and greater than 1, is will have
#             a list of distinct prime factors, and if this list has an
#             even number of values the Möbius number is 1, and if odd the
#             number -1. This can also be expressed as (-1)ⁿ, with n the
#             number of prime factors.

#             So what do we do with this function?
# 
#             Number throry, as a matter of course, is not traditionally
#             known for its practical application — an observation made
#             albeit a notable turnabout to that trend with the
#             applicability of prime number theory to  modern cryptographic
#             techniques. However within the field of number theory the
#             Möbius function is well explored and often encountered. Well,
#             often enough at least.

#             Summing over divisors is something commonly studied in the discipline,
#             and there the Möbius function is thus most often seen as a
#             component of the Möbius inversion function, which describes a
#             multiplicative relationship between certain pairs of
#             functions in this domain. The inversion function can be generalized into
#             arbitrary abelian groups in group theory and
#             partially-ordered sets in order theory. 
 
#             One property of the Möbius function is that the meta-function
#             describing the average order of the Möbius function can be
#             shown to be equivalent to the prime number theorum. From this
#             proof we can infer that the average order is 0, meaning that
#             there are equal numbers of squarefree numbers with even and
#             odd numbers of factors as the scale tends towards infinity.
 
#             Which is an interesting observation, if you're into that sort
#             of thing.
# 
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

my $input = shift @ARGV ;
say moebius_function( $input ) if defined $input;

sub moebius_function ( $input ) {
    return 1 if $input == 1;    
    
    our @primes = (2,3);  ## shared with subroutine
    my  $count = 0;

    add_next_prime() while $primes[-1] <= $input;
    
    ## check squarefree
    for (@primes) {
        if ($input % $_ == 0) {
            return 0 if $input % $_ ** 2 == 0 ;
            $count++;
        }
    }

    ## return based on odd or even count
    return (-1)**$count;
    
    sub add_next_prime ( ) {
    ## adds the next prime to external sequence
        
        my $candidate = $primes[-1] ;
        CANDIDATE: while ( $candidate += 2 ) {
            my $sqrt_candidate = sqrt( $candidate );
            for my $test ( @primes ) {
                next CANDIDATE if $candidate % $test == 0;
                last if $test > $sqrt_candidate;
            }
            push @primes, $candidate;
            last;
        }
    }
}


use Test::More;

is moebius_function( 5), -1, 'ex-1';
is moebius_function(10),  1, 'ex-2';
is moebius_function(20),  0, 'ex-3';

is moebius_function( 2), -1, 'edge-2';
is moebius_function( 3), -1, 'dege-3';

is moebius_function(46),  1, 'mid-46';
is moebius_function(47), -1, 'mid-47';
is moebius_function(48),  0, 'mid-48';


done_testing();
