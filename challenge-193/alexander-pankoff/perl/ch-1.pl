#!/usr/bin/env perl
package challenge193::ch1;

use strict;
use warnings;
use autodie;
use feature qw'say state signatures';
no warnings qw'experimental::signatures';

use Test::More tests => 2;

is_deeply( [ binary_string(2) ], [qw(00 01 10 11)], "Example 1" );
is_deeply(
    [ binary_string(3) ],
    [qw(000 001 010 011 100 101 110 111)],
    "Example 2"
);

sub binary_string ($n) {
    my $max = -1 + 2**$n;
    map { sprintf( "%0$n" . "b", $_ ) } 0 .. $max;
}
