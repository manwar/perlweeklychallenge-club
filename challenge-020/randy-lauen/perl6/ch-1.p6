#!/usr/bin/env perl6

# Write a script to accept a string from command line and split it on change of character.
# For example, if the string is “ABBCDEEF”, then it should split like “A”, “BB”, “C”, “D”, “EE”, “F”.

sub MAIN( Str $text ) {
    say $text.comb(/(.) {} $0*/).join(',');
}
