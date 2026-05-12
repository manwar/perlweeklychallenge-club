#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

sub main ( $str1, $str2 ) {
    my @arr1 = split /,/, $str1;
    my @arr2 = split /,/, $str2;

    say join( "", @arr1 ) eq join( "", @arr2 ) ? "true" : "false";
}

main(@ARGV);
