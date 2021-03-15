#!/usr/bin/perl
use warnings;
use strict;

use Text::Levenshtein qw{ distance };

sub edit_distance {
    my ($s1, $s2) = @_;
    distance($s1, $s2)
}

use Test::More tests => 3;

is edit_distance('kitten', 'sitting'), 3, 'Example 1';
is edit_distance('sunday', 'monday'), 2, 'Example 2';
is edit_distance('abcd', 'badc'), 3;
