#!/usr/bin/perl

use strict;
use warnings;
use Test::More;

sub decrypt_string {
    my ($str) = @_;

    # Use a regex that matches either \d\d# or \d
    # Note: we need to handle it from left to right to be correct,
    # but the problem implies a unique decomposition.
    # Actually, the # acts as a delimiter for the 2-digit cases.

    $str =~ s/(\d{2})#|(\d)/
        if (defined $1) {
            chr(ord('a') + $1 - 1)
        } else {
            chr(ord('a') + $2 - 1)
        }
    /ge;

    return $str;
}

is(decrypt_string("1326#"), "acz", "Example acz");
is(decrypt_string("10#11#12"), "jkab", "Example jkab");
is(decrypt_string("25#"), "y", "Example y");
is(decrypt_string("123"), "abc", "Example abc");

done_testing();
