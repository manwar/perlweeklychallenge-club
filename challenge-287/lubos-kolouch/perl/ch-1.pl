#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 5;

=pod

=head1 DESCRIPTION

This script determines the minimum number of steps required to make a given string a strong password based on the following criteria:

- At least 6 characters long.
- Contains at least one lowercase letter, one uppercase letter, and one digit.
- Does not contain three repeating characters in a row.

=head1 FUNCTIONS

=head2 strong_password_steps($s)

Calculates the minimum number of steps required to make the string a strong password.

=over 4

=item * C<$s> - The input string.

=back

Returns the minimum number of steps as an integer.

=cut

sub strong_password_steps {
    my ($s) = @_;
    my $missing_types = 3;
    $missing_types-- if $s =~ /[a-z]/;
    $missing_types-- if $s =~ /[A-Z]/;
    $missing_types-- if $s =~ /\d/;

    my $repeats_to_fix = 0;
    my $i = 2;
    my $n = length($s);
    while ($i < $n) {
        if (substr($s, $i, 1) eq substr($s, $i - 1, 1) and substr($s, $i - 1, 1) eq substr($s, $i - 2, 1)) {
            my $repeat_len = 3;
            while ($i + 1 < $n and substr($s, $i + 1, 1) eq substr($s, $i, 1)) {
                $repeat_len++;
                $i++;
            }
            $repeats_to_fix += int($repeat_len / 3);
        }
        $i++;
    }

    my $total_steps;
    if ($n >= 6) {
        $total_steps = ($missing_types > $repeats_to_fix) ? $missing_types : $repeats_to_fix;
    } else {
        my $insertions_needed = 6 - $n;
        my $sum = $missing_types + $repeats_to_fix;
        $total_steps = ($sum > $insertions_needed) ? $sum : $insertions_needed;
    }
    return $total_steps;
}

# Tests
is(strong_password_steps("a"), 5, 'Example 1');
is(strong_password_steps("aB2"), 3, 'Example 2');
is(strong_password_steps("PaaSW0rd"), 0, 'Example 3');
is(strong_password_steps("Paaasw0rd"), 1, 'Example 4');
is(strong_password_steps("aaaaa"), 3, 'Example 5');

