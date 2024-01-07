#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'max';

sub calculate_value ($s) {
    #Return the number if it looks like an integer else the length of string
    return $s =~ /^[0-9]+$/ ? int($s) : length($s);
}

sub main (@values) {
    say max( map { calculate_value($_) } @values );
}

main(@ARGV);