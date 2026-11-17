#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(Int);
use Test::More;

=head1 NAME

ch-1.pl - Three Power

=head1 SYNOPSIS

    perl ch-1.pl

=head1 DESCRIPTION

Solution for The Weekly Challenge 254, Task 1: Three Power.
Determines whether a given integer is a power of three (including 0 = 0^3
as specified in the challenge examples).

=head1 FUNCTIONS

=head2 is_power_of_three($n)

Returns 1 (true) if C<$n> is a power of three or 0, and 0 (false) otherwise.

=cut

signature_for is_power_of_three => (
    method     => 0,
    positional => [Int],
);

sub is_power_of_three ($n) {
    return 1 if $n == 0;
    return 0 if $n < 1;

    while ( $n % 3 == 0 ) {
        $n /= 3;
    }

    return $n == 1 ? 1 : 0;
}

is( is_power_of_three(27), 1, 'Example 1: 27 is a power of three' );
is( is_power_of_three(0),  1, 'Example 2: 0 is 0^3' );
is( is_power_of_three(6),  0, 'Example 3: 6 is not a power of three' );
is( is_power_of_three(1),  1, 'Edge case: 1 is 3^0' );
done_testing();
