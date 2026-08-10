#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

my $i = 0;
my %VALUE = map { $_ => $i++ } 0 .. 9, 'A' .. 'Z', 'a' .. 'z', '+', '/';

sub reverse_base($num, $base) {
    my $result = 0;
    for (my $n = 1; length $num; $n *= $base) {
        $result += $n * $VALUE{ substr $num, -1, 1, "" };
    }
    return $result
}

use Test::More tests => 5 + 1;

is reverse_base('101010', 2), 42, 'Example 1';
is reverse_base('EEADEE', 16), 15642094, 'Example 2';
is reverse_base('755', 8), 493, 'Example 3';
is reverse_base('1BRJB', 36), 2228519, 'Example 4';
is reverse_base('7MyqL', 64), 123456789, 'Example 5';

is reverse_base('+/', 64), 4031, '/ and +';
