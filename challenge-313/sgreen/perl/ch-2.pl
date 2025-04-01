#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main ($str) {
    # Extract letters from the string
    my @letters    = grep { /[a-z]/i } split //, $str;

    # Replace all letters (in reverse order) and display the string
    $str =~ s/[a-z]/pop(@letters)/ige;
    say $str;
}

main( $ARGV[0] );