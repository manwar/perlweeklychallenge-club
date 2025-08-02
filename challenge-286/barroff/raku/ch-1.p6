#!/usr/bin/env perl6

use v6.d;

#| Print a random word from this script
sub MAIN() {
    my $words = $*PROGRAM-NAME.IO.words.Set;
    say $words.pick;
}
