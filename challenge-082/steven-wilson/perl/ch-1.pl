#!/usr/bin/env perl
# Week 82 Task 1 solution by Steven Wilson. 

=encoding utf8

=head1 TASK #1 › Common Factors
Submitted by: Niels van Dijke

You are given 2 positive numbers $M and $N.

Write a script to list all common factors of the given numbers.
Example 1:

Input:
    $M = 12
    $N = 18

Output:
    (1, 2, 3, 6)

Explanation:
    Factors of 12: 1, 2, 3, 4, 6
    Factors of 18: 1, 2, 3, 6, 9

Example 2:

Input:
    $M = 18
    $N = 23

Output:
    (1)

Explanation:
    Factors of 18: 1, 2, 3, 6, 9
    Factors of 23: 1
=cut

use strict;
use warnings;
use Test::More;
use Math::Factor::XS qw/ factors /;

my @e1_t = qw/ 1 2 3 6 /;
my @e2_t = qw/ 1 /;
is_deeply( common_factors( 12, 18 ), \@e1_t, 'example 1' );
is_deeply( common_factors( 18, 23 ), \@e2_t, 'example 2' );
done_testing();

sub common_factors {
    my ( $first, $second ) = @_;
    my %first_factors  = map { $_ => 1 } factors($first);
    my @second_factors = factors($second);
    my @intersection   = sort { $a <=> $b }
        grep { exists $first_factors{$_} } @second_factors;
    unshift @intersection, 1;
    return \@intersection;
}
