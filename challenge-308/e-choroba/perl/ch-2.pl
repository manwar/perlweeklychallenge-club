#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub decode_xor($initial, @encoded) {
    my @decoded;
    for my $i ($initial, @encoded) {
        push @decoded, $i ^ ($decoded[-1] // 0);
    }
    return \@decoded
}

use Test2::V0;
plan(2 + 1);

is decode_xor(1, 1, 2, 3), [1, 0, 2, 1], 'Example 1';
is decode_xor(4, 6, 2, 7, 3), [4, 2, 0, 7, 4], 'Example 2';

is decode_xor(1, 1, 2, 5), [1, 0, 2, 7], 'Initial different to last';
