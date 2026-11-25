#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Int);
use Test::More;

=head1 NAME

ch-2.pl - Linear Recurrence of Second Order

=head1 SYNOPSIS

    perl ch-2.pl

=head1 DESCRIPTION

Solution for The Weekly Challenge 246, Task 2: Linear Recurrence of Second Order.
Determines whether an array of integers forms a second-order linear recurrence
C<a[n] = p * a[n-2] + q * a[n-1]> with integer coefficients C<p> and C<q>.

=head1 FUNCTIONS

=head2 is_linear_recurrence($a)

Returns C<1> if the integer arrayref C<$a> satisfies a second-order linear
recurrence with integer factors, or C<0> otherwise.

=cut

signature_for is_linear_recurrence => (
    method     => 0,
    positional => [ ArrayRef [Int] ],
);

sub is_linear_recurrence ($a) {
    return 0 if @{$a} < 5;

    my $det = $a->[0] * $a->[2] - $a->[1]**2;
    my ( $p, $q );

    if ( $det != 0 ) {
        my $p_num = $a->[2] * $a->[2] - $a->[1] * $a->[3];
        my $q_num = $a->[0] * $a->[3] - $a->[1] * $a->[2];
        return 0 if $p_num % $det != 0 || $q_num % $det != 0;
        $p = $p_num / $det;
        $q = $q_num / $det;
    }
    elsif ( $a->[0] == 0 ) {
        ( $p, $q ) = ( 0, 0 );
    }
    else {
        return 0 if $a->[1] % $a->[0] != 0;
        ( $p, $q ) = ( 0, $a->[1] / $a->[0] );
    }

    for my $i ( 2 .. $#{$a} ) {
        return 0 if $a->[$i] != $p * $a->[ $i - 2 ] + $q * $a->[ $i - 1 ];
    }

    return 1;
}

is( is_linear_recurrence( [ 1, 1, 2, 3,  5 ] ), 1, 'Example 1: Fibonacci sequence' );
is( is_linear_recurrence( [ 4, 2, 4, 5,  7 ] ), 0, 'Example 2: Even-odd mismatch' );
is( is_linear_recurrence( [ 4, 1, 2, -3, 8 ] ), 1, 'Example 3: Custom sequence' );
is( is_linear_recurrence( [ 1, 2, 4, 8, 16 ] ), 1, 'Geometric sequence (det == 0)' );
is( is_linear_recurrence( [ 0, 0, 0, 0,  0 ] ), 1, 'All zeros' );
done_testing();
