#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main ($input_string) {
    my ($word) = $input_string =~ /([a-z'-]*[a-z])[^a-z]*$/i;
    say length($word // '');
}

main( $ARGV[0] );
