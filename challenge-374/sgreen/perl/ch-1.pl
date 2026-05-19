#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

use List::Util 'any';

sub main ($input_string) {
    my $l        = length($input_string);
    my @vowels   = (qw/a e i o u/);
    my @solution = ();

    # Generate all possible substrings
    foreach my $start ( 0 .. $l - 4 ) {
        foreach my $length ( 5 .. $l - $start ) {
            my $substr = substr( $input_string, $start, $length );

            # Check string has only vowels
            if ( $substr !~ /^[aeiou]+$/ ) {
                next;
            }

            # Check the substr containers all vowels, and skip if it doesn't
            if ( any { index( $substr, $_ ) == -1 } @vowels ) {
                next;
            }

            push @solution, $substr;
        }
    }

    say "(" . join( ", ", map { qq{"$_"} } @solution ) . ")";
}

main(@ARGV);
