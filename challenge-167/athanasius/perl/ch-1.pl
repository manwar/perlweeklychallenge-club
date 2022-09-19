#!perl

###############################################################################
=comment

Perl Weekly Challenge 167
=========================

TASK #1
-------
*Circular Prime*

Submitted by: Mohammad S Anwar

Write a script to find out first 10 circular primes having at least 3 digits
(base 10).

Please checkout [ https://en.wikipedia.org/wiki/Circular_prime |wikipedia] for
more information.


        A circular prime is a prime number with the property that the number
        generated at each intermediate step when cyclically permuting its (base
        10) digits will also be prime.


Output

  113, 197, 199, 337, 1193, 3779, 11939, 19937, 193939, 199933

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Note
----
There are 2 definitions of "circular primes":

 1. "Numbers such that every cyclic permutation is a prime" [2]:
    2, 3, 5, 7, 11, 13, 17, 31, 37, 71, 73, 79, 97, 113, 131, 197, 199, ...
 2. As in 1, except that "Only the smallest member of the cyclic shift is
    listed." [1]: 2, 3, 5, 7, 11, 13, 17, 37, 79, 113, 197, 199, 337, 1193, ...

From the output shown in the Task description, it is evident that the circular
primes required here are those which satisfy definition 2.

Algorithm
---------
In base 10, all circular primes of 2 or more digits must be composed of the
digits 1, 3, 7, or 9 only.
    Rationale:
        any 2+ -digit integer ending in 0             is divisible by 2 and 5;
        any 2+ -digit integer ending in 2, 4, 6, or 8 is divisible by 2;
        any 2+ -digit integer ending in 5             is divisible by 5;
    and in any cycle, each digit must appear at least once in final position.

Accordingly, the algorithm begins by *constructing* possible solutions (i.e.,
integers containing just those digits):

1.  Let circ_primes = ()
2.  FOR d = 3, 4, 5, ... UNTIL circ_primes contains 10 elements
        3.  Find all combinations of d digits drawn from the set {1, 3, 7, 9}.
            As these are *combinations*, order is unimportant. For convenience,
            the digits in each combination are sorted in ascending numerical
            order.
        4.  Filter out combinations containing all 3s, all 7s, and all 9s.
                Rationale: Any integer of 2 or more digits in which the digits
                    are all 3, 7, or 9 is divisible by the repunit of the same
                    length. For example, 7777 = 1111 * 7.
        5.  FOR each combination c
                6.  Generate all the permutations of the digits in c
                7.  WHILE  there are permutations remaining
                         8. Remove the first permutation and store as p
                         9. Generate the cycle of integers beginning with p
                        10. If every member of the cycle is prime, store p in
                            circ_primes
                        11. Remove all members of the cycle from the remaining
                            permutations
                    ENDWHILE
            ENDFOR
    ENDFOR
12. Display the contents of circ_primes

Table of Circular Primes
------------------------
From [1]: 2, 3, 5, 7, 11, 13, 17, 37, 79,
          113, 197, 199, 337, 1193, 3779, 11939, 19937, 193939, 199933,
          1111111111111111111, 11111111111111111111111

References
----------
[1] "A016114  Circular primes (numbers that remain prime under cyclic shifts of
     digits).", OEIS, https://oeis.org/A016114
[2] "A068652  Numbers such that every cyclic permutation is a prime.", OEIS,
     https://oeis.org/A068652
[3] "Circular prime", Wikipedia, https://en.wikipedia.org/wiki/Circular_prime

=cut
#==============================================================================

use strict;
use warnings;
use Algorithm::Loops  qw( NestedLoops NextPermute );
use Const::Fast;
use List::MoreUtils   qw( bremove );
use Math::Prime::Util qw( is_prime );

const my $MIN_DIGITS =>  3;
const my $TARGET     => 10;
const my $USAGE      => "Usage:\n  perl $0\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 167, Task #1: Circular Prime (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;
       $args == 0 or die 'ERROR: Expected 0 command line arguments, found ' .
                         "$args\n$USAGE";

    my @circ_primes;

    L_OUTER: for (my $digits = $MIN_DIGITS; ; ++$digits)
    {
        my $combs = get_combinations( $digits );
           $combs = filter_reps( $combs );

        for my $comb (@$combs)
        {
            my $new_circ_primes = find_circular_primes( $comb );

            push @circ_primes, @$new_circ_primes;

            last L_OUTER if scalar @circ_primes >= $TARGET;
        }
    }

    printf "Output: %s\n", join ', ', @circ_primes[ 0 .. $TARGET - 1 ];
}

#------------------------------------------------------------------------------
sub find_circular_primes
#------------------------------------------------------------------------------
{
    my ($num)  = @_;
    my  $perms = get_permutations( $num );
    my  @circ_primes;

    while (scalar @$perms)
    {
        my $perm      = shift @$perms;
        my $cycle     = get_cycle( $perm );
        my $all_prime = 1;

        for my $n (@$cycle)
        {
            unless (is_prime( $n ))
            {
                $all_prime = 0;
                last;
            }
        }

        push @circ_primes, $perm if $all_prime;

        for my $n (@$cycle)
        {
            bremove { $_ <=> $n } @$perms;
        }
    }

    return \@circ_primes;
}

#------------------------------------------------------------------------------
sub get_permutations
#------------------------------------------------------------------------------
{
    my ($n)     = @_;
    my  @digits = split '', $n;    # Note: the digits are already sorted (asc.)
    my  @perms;

    do
    {
        my $perm = join '', @digits;

        push @perms, $perm;

    } while (NextPermute( @digits ));

    return \@perms;
}

#------------------------------------------------------------------------------
sub get_cycle                                # E.g., 137 -> 713 -> 371 [-> 137]
#------------------------------------------------------------------------------
{
    my ($first) = @_;
    my  @cycle  = $first;
    my  @digits = split '', $first;
    my  $next;

    do
    {
        my $last =  pop      @digits;
        @digits  = ($last,   @digits);
        $next    =  join '', @digits;

        push @cycle, $next;

    } until ($next eq $first);

    pop @cycle;

    return \@cycle;
}

#------------------------------------------------------------------------------
sub get_combinations
#------------------------------------------------------------------------------
{
    my ($depth) = @_;
    my  @combs;

    NestedLoops
    (
        [
            [ 1, 3, 7, 9 ],
            (
                sub
                {
                    $_ == 1 ? [ 1, 3, 7, 9 ] :
                    $_ == 3 ? [    3, 7, 9 ] :
                    $_ == 7 ? [       7, 9 ] :
                              [          9 ];
                }

            ) x ($depth - 1),
        ],
        sub
        {
            push @combs, join '', @_;
        },
    );

    return \@combs;
}

#------------------------------------------------------------------------------
sub filter_reps       # Remove 333, 777, 999, 3333, ..., but NOT 111, 1111, ...
#------------------------------------------------------------------------------
{
    my ($combs) = @_;
    my  @filtered;

    for my $comb (@$combs)
    {
        my @digits = split '', $comb;
        my %count;

        ++$count{ $_ } for @digits;

        if (scalar( keys %count ) > 1 || exists $count{ '1' })
        {
            push @filtered, $comb;
        }
    }

    return \@filtered;
}

###############################################################################
