#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

use Math::Base::Convert qw{ cnv };

sub is_brazilian_number ($n) {
    for my $base (2 .. $n - 2) {
        my $converted = cnv($n, 10, [0 .. $base - 1]);
        return 1 if $converted =~ /^(.)\1+$/;
    }
    return 0
}

use Test::More tests => 3;

is is_brazilian_number(7), 1, 'Example 1';
is is_brazilian_number(6), 0, 'Example 2';
is is_brazilian_number(8), 1, 'Example 3';
