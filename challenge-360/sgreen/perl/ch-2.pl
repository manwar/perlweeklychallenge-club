#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main ($str) {
    say join( " ", sort { lc($a) cmp lc($b) } split /\s+/, $str );
}

main(@ARGV);
