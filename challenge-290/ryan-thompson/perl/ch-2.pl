#!/usr/bin/env perl
#
# 2024 Ryan Thompson <rjt@cpan.org>

use 5.036;
no warnings 'uninitialized';
use List::Util qw< sum0 >;

sub luhn($str) {
    my $idx = 0;

    my $sum = sum0 map {
        $idx++;

        $idx == 1 ? $_                # Check digit
      : $idx  % 2 ? $_                # Even digit
      : $_ >= 5   ? (2 * $_) % 10 + 1 # Odd digit >= 5
      :             (2 * $_)          # Odd digit <  5
    } grep /\d/, reverse split '', $str;

    $sum % 10 == 0
}

use Test2::V0;

ok  luhn("17893729974"),            'Example 1';
ok  luhn("4137 8947 1175 5904"),    'Example 2';
ok !luhn("4137 8974 1175 5904"),    'Example 3';
ok  luhn("12344"),                  'Short number';
ok !luhn("12345"),                  'Short number (fail check)';

# Degenerate cases
ok  luhn(0),                        'Sum of no digits % 10 == 0';
ok  luhn(''),                       'Empty string passes';
ok  luhn(-12344),                   'Negative sign ignored';
ok  luhn('Contains no numbers'),    'Equivalent to empty string';

done_testing;
