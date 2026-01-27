#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'max';

sub main (@input_strings) {
    say max( map { /^\d+$/ ? $_ : length($_) } @input_strings );
}

main(@ARGV);
