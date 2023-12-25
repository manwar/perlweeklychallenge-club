#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main ( $word, $char ) {
    # Obtain the positions of the character in the string
    my @positions = ();
    foreach my $i ( 0 .. length($word) - 1 ) {
        push @positions, $i if substr( $word, $i, 1 ) eq $char;
    }

    if ( $#positions == -1 ) {
        # Throw an error if we don't find the character in the string
        die "'$char' does not appear in string\n";
    }

    # Record the position of the first occurrence of the character, and the next
    my $current_pos = shift(@positions);
    my $next_pos    = shift(@positions) // $current_pos;

    my @solution = ();
    foreach my $i ( 0 .. length($word) - 1 ) {
        if ( abs( $i - $next_pos ) < abs( $i - $current_pos ) ) {
            # We are closer to the next occurrence of the character
            $current_pos = $next_pos;
            $next_pos    = shift(@positions) // $current_pos;
        }

        # Record the closest occurrence for this position
        push @solution, abs( $i - $current_pos );
    }

    # Print the solution
    say '(', join( ',', @solution ), ')';
}

main(@ARGV);