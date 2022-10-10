#! /usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

my $XD4 = qr/[[:xdigit:]]{4}/;
sub mac_address ($addr) {
    die 'Invalid input' if $addr !~ /^$XD4\.$XD4\.$XD4$/;

    $addr =~ s/\.//g;
    substr $addr, 3 * $_ - 1, 0, ':' for 1 .. 5;
    return $addr
}

use Test2::V0;
plan 6;

is mac_address('1ac2.34f0.b1c2'), '1a:c2:34:f0:b1:c2', 'Example 1';
is mac_address('abc1.20f1.345a'), 'ab:c1:20:f1:34:5a', 'Example 2';

is mac_address('ABC1.20F1.345A'), 'AB:C1:20:F1:34:5A', 'Case';

like dies { mac_address('x123.1234.abcd')  }, qr/Invalid input/, 'Invalid char';
like dies { mac_address('123.1234.abcd')   }, qr/Invalid input/, 'Too short';
like dies { mac_address('1234.12345.abcd') }, qr/Invalid input/, 'Too long';
