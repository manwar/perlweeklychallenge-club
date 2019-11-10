#!/usr/bin/env perl
use v5.16;
use strict;
use warnings;

# We define letters as graphemes in any language supported by Perl that
# match the Alpha class.  We display how many times each grapheme
# appears in the files.

MAIN: {
    my %letters;
    while (<<>>) {
        s/\P{Alpha}//gms;
        for my $char (split //) {
            $letters{fc $char}++;
        }
    }

    for my $key (sort keys %letters) {
        say "$key: " . $letters{$key};
    }
}

