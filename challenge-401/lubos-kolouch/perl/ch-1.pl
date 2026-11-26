#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(Str);
use Test::More;

=head1 NAME

ch-1.pl - Fractional Addition Substraction

=head1 SYNOPSIS

    perl ch-1.pl

=head1 DESCRIPTION

Solution for The Weekly Challenge 401, Task 1: Fractional Addition Substraction.
Parses an expression of fraction additions and subtractions, computes the
reduced sum, and returns it formatted as C<numerator/denominator>.

=head1 FUNCTIONS

=head2 fraction_addition($expr)

Evaluates the fractional expression string C<$expr> and returns the reduced
result as a string (with denominator C<1> for integer results).

=cut

sub _gcd ( $a, $b ) {
    $a = abs $a;
    $b = abs $b;
    while ( $b != 0 ) {
        ( $a, $b ) = ( $b, $a % $b );
    }
    return $a;
}

signature_for fraction_addition => (
    method     => 0,
    positional => [Str],
);

sub fraction_addition ($expr) {
    my $num = 0;
    my $den = 1;

    while ( $expr =~ m/([+-]?\d+)\/(\d+)/msg ) {
        my ( $n, $d ) = ( int($1), int($2) );
        $num = $num * $d + $n * $den;
        $den = $den * $d;
        my $g = _gcd( $num, $den );
        $num /= $g;
        $den /= $g;
    }

    return "$num/$den";
}

is( fraction_addition('1/2+3/2'),        '2/1',   'Example 1' );
is( fraction_addition('-5/2-3/2'),       '-4/1',  'Example 2' );
is( fraction_addition('5/3-5/3'),        '0/1',   'Example 3' );
is( fraction_addition('10/10-1/10+2/5'), '13/10', 'Example 4' );
is( fraction_addition('1/6+1/6+1/6'),    '1/2',   'Example 5' );
done_testing();
