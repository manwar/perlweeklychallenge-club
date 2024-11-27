#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub sc ($s) {
    return length($s) . substr( $s, 0, 1 );
}

sub main ($str) {
    $str =~ s/(([a-z])\2+)/sc($1)/ge;
    say $str;
}

main( $ARGV[0] );