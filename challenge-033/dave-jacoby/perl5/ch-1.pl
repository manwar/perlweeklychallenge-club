#!/usr/bin/env perl

use strict ;
use warnings ;
use utf8 ;
use feature qw{ postderef say signatures state } ;
no warnings qw{ experimental::postderef experimental::signatures } ;

# Create a script that accepts one or more files specified
# on the command-line and count the number of times letters
# appeared in the files.

for my $file ( @ARGV ) {

    # -f $file => Does file exits
    # open fails is file is unreadable
    if ( -f $file && open my $fh, '<', $file ) {
        my %hash ;

        # turn the multiline array from the filehandle
        # into a string
        my $text = join '', <$fh> ;

        # split the string into characters, use lc to make them
        # all lowercase, and remove non-lowercase-letters
        my @text = grep { /[a-z]/ } map { lc } split //, $text ;

        # count each letter
        for my $l ( @text ) { $hash{ $l }++ }

        # and we go through each letter, and print the value
        # or zero, if there isn't a value
        say $file;
        say '=' x length $file ;
        for my $l ( 'a' .. 'z' ) {
            say join ': ', $l, $hash{ $l } || 0 ;
            }
        say '' ;
        }
    }
