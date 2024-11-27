#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 3;

=pod

=head1 DESCRIPTION

This script implements Luhn's Algorithm to validate a given string of digits.

Given a string containing digits (and possibly other characters), the script:

1. Extracts all digits from the string.
2. Considers the last digit as the payload (check digit).
3. Starting from the right (excluding the payload), doubles every other digit.
4. If doubling results in a number greater than 9, subtracts 9 from it.
5. Sums all the adjusted digits.
6. Calculates the correct check digit, which is the number needed to bring the total modulo 10 to zero.
7. Returns 'true' if the payload matches the correct check digit, 'false' otherwise.

=head1 FUNCTIONS

=head2 luhn_algorithm($str)

Validates the input string using Luhn's Algorithm.

=over 4

=item * C<$str> - The input string containing digits and possibly other characters.

=back

Returns 'true' if the payload matches the correct check digit, 'false' otherwise.

=cut

sub luhn_algorithm {
    my ($str) = @_;
    my @digits = $str =~ /(\d)/g;

    # Return false if there are not enough digits
    return 'false' if @digits < 2;

    my $payload = pop @digits;
    my @reversed_digits = reverse @digits;

    my $sum = 0;
    for my $i (0 .. $#reversed_digits) {
        my $digit = $reversed_digits[$i];
        if ($i % 2 == 0) {
            $digit *= 2;
            $digit -= 9 if $digit > 9;
        }
        $sum += $digit;
    }

    my $total = $sum + $payload;
    my $correct_check_digit = (10 - ($sum % 10)) % 10;

    return $payload == $correct_check_digit ? 'true' : 'false';
}

# Unit Tests
is(luhn_algorithm("17893729974"), 'true', 'Example 1');
is(luhn_algorithm("4137 8947 1175 5904"), 'true', 'Example 2');
is(luhn_algorithm("4137 8974 1175 5904"), 'false', 'Example 3');

done_testing();
