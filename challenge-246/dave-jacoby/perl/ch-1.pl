#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

say join "\n", 
    sort { $a <=> $b }      # and the example is sorted numerically, so we will
    map { 1 + int rand 49 } # which are random and between 1 and 49
                            # but int rand ( n ) will give a number between 0 and n-1
                            # so adding 1 will put it at the right range
    1 .. 6;                 # we want six numbers


