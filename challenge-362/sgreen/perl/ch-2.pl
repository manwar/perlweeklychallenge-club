#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use Lingua::EN::Numbers 'num2en';

sub main (@ints) {
    my @sorted_ints = sort { num2en($a) cmp num2en($b) } @ints;
    say join( ", ", @sorted_ints );
}

main(@ARGV);
