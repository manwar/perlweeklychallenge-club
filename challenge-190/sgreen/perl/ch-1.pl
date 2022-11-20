#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main ($s) {
    # See if the string is all one case, or starts with a capital and then
    #  lower case letters.
    say $s =~ /^[A-Z]?([A-Z]+|[a-z]+)$/ ? 1 : 0;
}

main( $ARGV[0] );