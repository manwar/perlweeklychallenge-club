#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

sub decrypt_string {
    my ($str) = @_;

    # We must match the ##@# patterns first to avoid greedy digit matching
    $str =~ s/(\d{2})#/chr(96 + $1)/eg;
    $str =~ s/(\d)/chr(96 + $1)/eg;

    return $str;
}

# Tests
is(decrypt_string("10#11#12"), "jkab", 'Example 1');
is(decrypt_string("1326#"), "acz", 'Example 2');
is(decrypt_string("25#"), "y", 'Extra: single hash');
is(decrypt_string("123456789"), "abcdefghi", 'Extra: digits only');

done_testing();
