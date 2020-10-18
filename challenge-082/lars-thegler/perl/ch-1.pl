#!/usr/bin/env perl

use Modern::Perl;

# TASK #1 › Common Factors
# Submitted by: Niels van Dijke
# You are given 2 positive numbers $M and $N.

# Write a script to list all common factors of the given numbers.

# Example 1:
# Input:
#     $M = 12
#     $N = 18

# Output:
#     (1, 2, 3, 6)

# Explanation:
#     Factors of 12: 1, 2, 3, 4, 6
#     Factors of 18: 1, 2, 3, 6, 9
# Example 2:
# Input:
#     $M = 18
#     $N = 23

# Output:
#     (1)

# Explanation:
#     Factors of 18: 1, 2, 3, 6, 9
#     Factors of 23: 1

my ( $M, $N ) = @ARGV;

my %factors;
for ( $M, $N ) {
    for my $f ( factor($_) ) {
        $factors{$_}++ for $f->@*;
    }
}

my @common_factors;
for my $f (sort keys %factors) {
    push @common_factors, $f if $factors{$f} == 2;
}

say sprintf "(%s)", join ', ', @common_factors;

sub factor
{
    my $n = shift;
    my @factors;
    for my $f ( 1 .. int( $n / 2 ) ) {
        push @factors, $f unless $n % $f;
    }
    return \@factors;
}
