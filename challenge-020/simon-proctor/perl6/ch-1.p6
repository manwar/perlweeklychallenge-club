#!/usr/bin/env perl6

use v6;

multi sub MAIN ( Bool :h(:$help) where so * ) {
    say $*USAGE;
}

#| Takes a string and outputs it broken into sets of the same character
multi sub MAIN ( Str $input is copy ) {
    while my $m = $input ~~ s!^$<match>=((.)$0*)!! {
        $m<match>.Str.say;
    }
}