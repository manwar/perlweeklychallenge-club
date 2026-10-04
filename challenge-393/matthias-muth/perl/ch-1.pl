#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 393 Task 1: Pythagoras Multiplied
#
#       Perl solution by Matthias Muth.
#

use v5.36;

# Euclid's formula states that for m > n > 0, the triple
#     (m²-n², 2mn, m²+n²)
# is a Pythagorean triple.
# For producing 'primitive' triples only (those that cannot be
# scaled down any further by an integer factor),
#   - m and n need to be coprime (i.e. have no common divisor except 1),
#   - and exactly one of them must be even.
# This solution produces primitive triples only, using Euclid's formula,
# and counts their k-fold multiples up to the given size limit.

use Math::Prime::Util qw( gcd );

sub pythagoras_multiplied_euclid( $limit ) {
    my $count = 0;
    # For any m, a lower bound for the hypotenuse is m² + 1.
    # End the loop if that exceeds the limit.
    for ( my $m = 2; $m * $m + 1 <= $limit; $m++ ) {
        # Make n loop over odd numbers if m is even, and vice versa. 
        for ( my $n = 1 + $m % 2; $n < $m; $n += 2 ) {
            # Only c is needed, for checking against the limit,
            # and for calculating the number of scaled up triples
            # whose hypotenuses stay within the limit.
            my $c = $m * $m + $n * $n;
            last if $c > $limit;        # Check against the limit.
            next if gcd( $m, $n ) != 1; # Make sure (m, n ) are coprime
                                        # for primitive triples.
            # Add all triples (k*a, k*b, k*c) that have k*c <= limit.
            # We don't need a loop for that, and we actually don't need
            # a or b either.
            $count += int( $limit / $c );
        }
    }
    # Both (a, b, c) and (b, a, c) count, and they are always distinct.
    # If a and b were equal, a²+b²=c² would mean 2a²=c²,
    # which does not have an integer solution because sqrt(2) is
    # irrational.
    return 2 * $count;
}

# Double loop solution:
# The first possible triple is [ 3, 4, 5 ], so the loops for c and a
# can start with 5 and 3, respectively.
# For making sure that a is the short side (a < b), a² must not be larger
# than c²/2.
# We know that a and b can never be both integers *and* equal to each other
# if c is an integer, because if they were equal, it would mean that c² = 2b²,
# and thus b = c / sqrt(2), which is an irrational number.
# Therefore, ( a, b ) and ( b, a ) are always distinct solutions, and we can
# always count both.

sub pythagoras_multiplied( $n ) {
    my $count = 0;
    for my $c ( 5..$n ) {
        my $c_squared = $c * $c;
        for my $a( 3..$c ) {
            my $a_squared = $a * $a;
            last if 2 * $a_squared >= $c_squared;
            my $b = sqrt( $c_squared - $a_squared );
            $count += 2
                if $b == int( $b );
        }
    }
    return $count;
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1", 20, 12 ],
    [ "Example 2", 7, 2 ],
    [ "Example 3", 1, 0 ],
    [ "Example 4", 15, 8 ],
    [ "Example 5", 30, 22 ],
);

is pythagoras_multiplied( $_->[1] ), $_->[2], $_->[0]
    for @tests;

done_testing;
