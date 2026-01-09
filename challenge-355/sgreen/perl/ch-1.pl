#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use Number::Format 'format_number';

sub main ($int) {
    say format_number($int);
}

main($ARGV[0]);