#! /usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

sub digital_clock ($pattern) {
    my $pos = index $pattern, '?';

    my ($regex, $then, $else) = @{
        {4 => [qr/./,       9],
         3 => [qr/./,       5],
         1 => [qr/^[01]/,   9, 3],
         0 => [qr/^.[4-9]/, 1, 2]
        }->{$pos}
    };
    return $pattern =~ $regex ? $then : $else
}

use Test::More tests => 6 + 1;

is digital_clock('?5:00'), 1, 'Example 1';
is digital_clock('?3:00'), 2, 'Example 2';
is digital_clock('1?:00'), 9, 'Example 3';
is digital_clock('2?:00'), 3, 'Example 4';
is digital_clock('12:?5'), 5, 'Example 5';
is digital_clock('12:5?'), 9, 'Example 6';

is digital_clock('?4:00'), 1, '24 invalid';
