#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

use List::Util 'any';
use List::MoreUtils 'first_index';

sub main (@seq) {
    # Check we have valid input
    my $valid_chars = join("", "?", "a".."z");
    if (   scalar(@seq) != 5
        or scalar( grep { $_ eq "?" } @seq ) != 1
        or any { index($valid_chars, $_) == -1 } @seq)
    {
        die "I expected four lower case letters and a question mark\n";
    }

    # Get the position of the unknown letter
    my $pos = first_index { $_ eq "?" } @seq;

    if ( $pos == 0 ) {
        # If it is first, we take the even difference from the second letter
        say chr( ord( $seq[1] ) - ( ord( $seq[3] ) - ord( $seq[2] ) ) );
    }
    else {
        # Otherwise we use the difference from the previous letter
        my $diff_pos = ( undef, 2, 3, 0, 1 )[$pos];
        say chr(
            ord( $seq[ $pos - 1 ] ) +
            ord( $seq[ $diff_pos + 1 ] ) -
            ord( $seq[$diff_pos] )
        );
    }
}

main(@ARGV);
