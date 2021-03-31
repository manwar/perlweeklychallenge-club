#!/usr/bin/perl
use warnings;
use strict;

sub decimal_string {
    my ($n, $d) = @_;
    my ($abs_n, $abs_d) = map abs, $n, $d;
    my $result = join "",
                      ($n < 0 xor $d < 0) ? '-' : "",
                      int($abs_n / $abs_d),
                      '.';
    my %seen = (my $remainder = $abs_n % $abs_d => 0);
    my $i = 1;
    while ($remainder != 0) {
        $remainder *= 10;
        $result .= my $r_digit = int($remainder / $abs_d);
        my $new_remainder = $remainder % $abs_d;
        if (exists $seen{$new_remainder}) {
            substr $result,
                   1 + index($result, '.') + $seen{$new_remainder},
                   0, '(';
            return "$result)"
        }
        $seen{ $remainder = $new_remainder } = $i++;
    }
    return $result =~ s/\.$/.0/r
}

use Test::More tests => 6;
is decimal_string(1,  3), '0.(3)',   'Example 1';
is decimal_string(1,  2), '0.5',     'Example 2';
is decimal_string(5, 66), '0.0(75)', 'Example 3';

is decimal_string(-22, 7), '-3.(142857)', '-22/7';
is decimal_string(3, -8), '-0.375', '3/-8';
is decimal_string(-99, 9), '-11.0', '-99/9';
