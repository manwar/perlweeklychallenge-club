#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use constant {true =>  !! 1,
              false => !! 0};

sub string_alike($str) {
    $str =~ tr/aeiouAEIOU//
    &&
    substr($str, 0, length($str) / 2) =~ tr/aeiouAEIOU//
    ==
    substr($str, length($str) / -2) =~ tr/aeiouAEIOU//
}

use Test2::V0;
plan(5);

is string_alike('textbook'), bool(false), 'Example 1';
is string_alike('book'), bool(true), 'Example 2';
is string_alike('AbCdEfGh'), bool(true), 'Example 3';
is string_alike('rhythmmyth'), bool(false), 'Example 4';
is string_alike('UmpireeAudio'), bool(false), 'Example 5';
