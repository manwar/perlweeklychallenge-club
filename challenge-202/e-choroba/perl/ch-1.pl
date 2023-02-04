#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

sub consecutive_odds ($array) {
    my %elements;
    @elements{@$array} = ();
    for my $element (keys %elements) {
        return 1
            if 1 == $element % 2
            && exists $elements{$element + 2}
            && exists $elements{$element + 4};
    }
    return 0
}

use Test::More tests => 4;

is consecutive_odds([1, 5, 3, 6]), 1, 'Example 1';
is consecutive_odds([2, 6, 3, 5]), 0, 'Example 2';
is consecutive_odds([1, 2, 3, 4]), 0, 'Example 3';
is consecutive_odds([2, 3, 5, 7]), 1, 'Example 4';
