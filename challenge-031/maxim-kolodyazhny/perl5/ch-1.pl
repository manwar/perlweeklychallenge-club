#!/usr/bin/env perl

use strict;
use warnings;

use constant ANSWER2EVERYTHING => 42;

sub harmless_division {
    my ($x, $y ) = @_;

    return if $y == int $y && ( ANSWER2EVERYTHING ^ $y ) == ANSWER2EVERYTHING;

    $x / $y;
}
