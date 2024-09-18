#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 7;

=pod

=head1 DESCRIPTION

This script determines if the given string is a valid number based on specific rules.

A valid number is defined as:

- An integer number followed by an optional exponent.
- A decimal number followed by an optional exponent.

An integer number is defined with an optional sign '-' or '+' followed by digits.

=head1 DEFINITIONS

=head2 Decimal Number

A decimal number is defined with an optional sign '-' or '+' followed by one of the following:

- Digits followed by a dot '.'.
- Digits followed by a dot '.' followed by digits.
- A dot '.' followed by digits.

=head2 Exponent

An exponent is defined with an exponent notation 'e' or 'E' followed by an integer number.

=head1 FUNCTIONS

=head2 is_valid_number($s)

Determines if the given string is a valid number.

=over 4

=item * C<$s> - The input string.

=back

Returns 1 if valid, 0 otherwise.

=cut

sub is_valid_number {
    my ($s) = @_;
    my $pattern = qr/
        ^                       # Start of string
        [+-]?                   # Optional sign
        (
            (                   # Decimal numbers
                \d+\.\d*        # Digits followed by dot and optional digits
                |
                \.\d+           # Dot followed by digits
                |
                \d+\.           # Digits followed by dot
            )
            |
            \d+                 # Integer numbers
        )
        ([eE][+-]?\d+)?         # Optional exponent
        $                       # End of string
    /x;
    return $s =~ $pattern ? 1 : 0;
}

# Unit Tests
is(is_valid_number("1"),     1, 'Example 1');
is(is_valid_number("a"),     0, 'Example 2');
is(is_valid_number("."),     0, 'Example 3');
is(is_valid_number("1.2e4.2"),0, 'Example 4');
is(is_valid_number("-1."),   1, 'Example 5');
is(is_valid_number("+1E-8"), 1, 'Example 6');
is(is_valid_number(".44"),   1, 'Example 7');

