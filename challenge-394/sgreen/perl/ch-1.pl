#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

use List::Util 'min';

use constant UCL => "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
use constant LCL => "abcdefghijklmnopqrstuvwxyz";

sub is_alt_case( $s, $upper_first ) {
    my $pos = 0;
    foreach my $letter ( split( //, $s ) ) {
        my $next_letters = ( $upper_first + $pos ) % 2 ? UCL : LCL;
        if ( index( $next_letters, $letter ) != -1 ) {
            # Correct case, move on to the next letter
            ++$pos;
            next;
        }

        # Find the position of the next letter of the expected case, and return
        # one less than that position
        foreach my $i ( $pos + 1 .. length($s) - 1 ) {
            if ( index( $next_letters, substr( $s, $i, 1 ) ) != -1 ) {
                return $i - 1;
            }
        }

        # This should never be called
        die "Unexpected situation happened\n";
    }

    # All the letters are correct
    return -1;
}

sub swap_letters( $s, $pos ) {
    # Swap the letters at pos and pos+1 around
    substr( $s, $pos, 2 ) = reverse( substr( $s, $pos, 2 ) );
    return $s;
}

sub main ($input_string) {
    # Check the are string is an even length, only contains letters, and half
    #  of them are upper case
    my $half_length = length($input_string) / 2;
    if ( length($input_string) % 2 ) {
        die "String must have an even number of characters\n";
    }
    if ( $input_string !~ /^[a-z]+$/i ) {
        die "The word contain non-letter characters\n";
    }
    my $upper_count = grep { index( UCL, $_ ) != -1 } split //, $input_string;
    if ( $upper_count != $half_length ) {
        die
          "Letters must contain the same number of upper and lower case letters\n";
    }

    my @move_list = ();

    foreach my $upper_first ( 0, 1 ) {
        my $s     = $input_string;
        my $moves = 0;

        while (1) {
            my $next_swap_pos = is_alt_case( $s, $upper_first );
            if ( $next_swap_pos == -1 ) {
                last;
            }
            $s = swap_letters( $s, $next_swap_pos );
            ++$moves;
        }

        push @move_list, $moves;
    }

    say min(@move_list);
}

main(@ARGV);
