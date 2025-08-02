#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'mesh';

sub main (@words) {
    my @arrays = map { [ split // ] } @words;
    say join( '', mesh(@arrays) );
}

main(@ARGV);