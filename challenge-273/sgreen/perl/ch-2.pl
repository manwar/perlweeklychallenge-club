#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main ($str) {
    # Check that no 'a' is after the first 'b'
    say $str =~ /^[^b]*b[^a]*$/ ? 'true' : 'false';
}

main(@ARGV);