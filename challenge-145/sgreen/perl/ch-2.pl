#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use List::Util 'none';

sub main {
    my $word    = shift;
    my @strings = ();

    # Make the starting point from each character
    foreach my $i ( 0 .. length($word) - 1 ) {

        # And the end point
        foreach my $j ( $i .. length($word) ) {

            # This is string we will examine
            my $s = substr( $word, $i, $j - $i );

            # If we don't already know about it, and it's palindromic, add
            #  it to the string array
            if ( none { $s eq $_ } @strings and $s eq reverse($s) ) {
                push @strings, $s;
            }
        }
    }

    say join ' ', @strings;
}

main(@ARGV);
