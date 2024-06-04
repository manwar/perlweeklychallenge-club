#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub defang_ip_address($address) {
    $address =~ s/[.]/[.]/gr
}

use Test::More tests => 2;

is defang_ip_address('1.1.1.1'), '1[.]1[.]1[.]1', 'Example 1';
is defang_ip_address('255.101.1.0'), '255[.]101[.]1[.]0', 'Example 2';
