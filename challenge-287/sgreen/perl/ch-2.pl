#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub valid_number ($str) {
    # Check if the given string is a valid number

    if ($str =~ /^[+-]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][+-]?[0-9]+)?$/) {
        say 'true';
    }
    else {
        say 'false';
    }
}

valid_number($ARGV[0]);