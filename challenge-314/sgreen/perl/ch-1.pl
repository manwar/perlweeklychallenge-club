#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util qw(all min sum);

sub all_same(@substrs) {
    return all { $_ eq $substrs[0] } @substrs;
}

sub main (@strs) {
    # Find the length of the shortest string, and the total strings
    my $shortest_length = min( map { length } @strs );
    my $combined_length = sum( map { length } @strs );

    # Find the most common prefix of all strings
    for ( my $l = $shortest_length ; $l >= 1 ; $l-- ) {
        if ( all_same( map { substr( $_, 0, $l ) } @strs ) ) {
            # We have the answer. Return the characters NOT remaining
            say $combined_length - scalar(@strs) * $l;
            return;
        }
    }

    # The first character is not the same
    say -1;
}

main(@ARGV);
