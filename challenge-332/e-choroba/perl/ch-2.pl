#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub odd_letters($str) {
    my %letter;
    ++$letter{$_} for split //, $str;
    return ! grep 0 == $_ % 2, values %letter
}

use Test2::V0;
plan(3);

is odd_letters('weekly'), bool(0), 'Example 1';
is odd_letters('perl'), bool(1), 'Example 2';
is odd_letters('challenge'), bool(0), 'Example 3';
