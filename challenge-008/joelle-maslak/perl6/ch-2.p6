#!/usr/bin/env perl6
use v6;

#
# Copyright © 2019 Joelle Maslak
# All Rights Reserved - See License
#

# Some changes between the challenge assumptions and what this handles:
#
# Words in the word list don't have to be the same length as the start
# and end words.  Words in the list that differ in length from the
# start/end words are just excluded from consideration.
#
# This doesn't care if the words in the list are alphabetical.
#
# Duplicates in the world list won't cause an issues.

sub MAIN(Str:D $file = 'ch-2.txt') {
    my @lines = $file.IO.lines;
    say join("\n", center(@lines));
}

sub center(@lines) {
    my $maxlen = @lines».chars.max;
    return @lines.map( { " " x (($maxlen - $_.chars)/2) ~ $_ } );
}

