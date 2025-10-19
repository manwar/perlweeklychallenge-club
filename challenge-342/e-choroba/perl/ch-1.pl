#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::MoreUtils qw{ part mesh };

sub balance_string($str) {
    my ($letters, $digits) = map [sort @{ $_ // [] }],
                             part { tr/0-9// }
                             split //, $str;
    $_ //= [] for $letters, $digits;
    return "" if abs(@$letters - @$digits) > 1;

    my $cmp = @$letters <=> @$digits;
    return join "", grep defined, 1 == $cmp ? mesh(@$letters, @$digits)
                                            : mesh(@$digits, @$letters)
}

use Test::More tests => 5 + 3;

is balance_string('a0b1c2'), '0a1b2c', 'Example 1';
is balance_string('abc12'), 'a1b2c', 'Example 2';
is balance_string('0a2b1c3'), '0a1b2c3', 'Example 3';
is balance_string('1a23'), "", 'Example 4';
is balance_string('ab123'), '1a2b3', 'Example 5';

is balance_string(""), "", 'Empty input';
is balance_string('1'), '1', 'Single digit';
is balance_string('a'), 'a', 'Single char';
