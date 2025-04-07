#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub subsequence($str1, $str2) {
    return $str2 =~ join '.*', split //, $str1
}

use Test2::V0;
plan(3);

is subsequence('uvw', 'bcudvew'), bool(1), 'Example 1';
is subsequence('aec', 'abcde'), bool(0), 'Example 2';
is subsequence('sip', 'javascript'), bool(1), 'Example 3';
