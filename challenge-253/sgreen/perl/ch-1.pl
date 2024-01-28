#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub split_strings ( $words, $sep ) {
    # Join the words together by the separator
    my $combined = join( $sep, @$words );

    # Some characters next to be escaped in perl. From
    #  https://perldoc.perl.org/perlrequick
    if ( index( '{}[]()^$.|*+?\\', $sep ) != -1 ) {
        $sep = "\\$sep";
    }

    # Split them by the separator excluding empty strings
    my @result = grep { length($_) } split( /$sep/, $combined );
    return \@result;
}

sub main (@inputs) {
    # The separator is the last character
    my $sep    = pop(@inputs);
    my $result = split_strings( \@inputs, $sep );
    say '"', join( '", "', @$result ), '"';
}

main(@ARGV);