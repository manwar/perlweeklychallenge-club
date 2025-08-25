#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
#  
#=============================================================================

use v5.42;
use feature 'class'; no warnings "experimental::class";

class TTTPlayer
{
    field $name :param :reader;
    field $bitmap = 0;

    method move($r, $c) {
        my $bit = ($r * 3) + $c;
        $bitmap |= (1 << $bit);
        return $self;
    }

    method hasWin() {
        use feature 'keyword_any'; no warnings "experimental::keyword_any";

        state @Win = ( 0b111000000, # Row 1
                       0b000111000, # Row 2
                       0b000000111, # Row 3
                       0b100100100, # Column 1
                       0b010010010, # Column 2
                       0b001001001, # Column 3
                       0b100010001, # Diagon l NW to SE
                       0b001010100, # Diagonal NE to SW
        );
        return any { ($bitmap & $_ ) == $_ } @Win;
    }

    method asString() {
        return sprintf("%s %0.9b", $name, $bitmap);
    }
}

1;
