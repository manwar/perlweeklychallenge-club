#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'max';

sub main (@array) {
    @array = sort { $a <=> $b } @array;
    my $solution1 = $array[-3] * $array[-2] * $array[-1];
    my $solution2 = $array[0] * $array[1] * $array[-1];
    say max( $solution1, $solution2 );
}

main(@ARGV);