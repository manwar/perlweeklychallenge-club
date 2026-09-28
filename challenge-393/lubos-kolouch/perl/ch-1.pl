#!/usr/bin/env perl
use v5.38;
use warnings;
use Test::More;

=head1 NAME

ch-1.pl - Pythagoras Multiplied

=head1 DESCRIPTION

You are given a positive integer C<$n>.

Find the number of all positive integer triplets (a, b, c) so that
a^2 + b^2 = c^2 and a, b and c are integers <= n.

=cut

sub count_pythagorean_triplets ($n) {
    return 0 if $n < 5;

    my $count = 0;
    for my $a ( 1 .. $n ) {
        my $a2 = $a * $a;
        for my $b ( 1 .. $n ) {
            my $c2 = $a2 + $b * $b;
            my $c  = int( sqrt($c2) );
            if ( $c <= $n && $c * $c == $c2 ) {
                $count++;
            }
        }
    }

    return $count;
}

# TESTS
is( count_pythagorean_triplets(20), 12, 'Example 1: n = 20' );
is( count_pythagorean_triplets(7),  2,  'Example 2: n = 7' );
is( count_pythagorean_triplets(1),  0,  'Example 3: n = 1' );
is( count_pythagorean_triplets(15), 8,  'Example 4: n = 15' );
is( count_pythagorean_triplets(30), 22, 'Example 5: n = 30' );

done_testing;
