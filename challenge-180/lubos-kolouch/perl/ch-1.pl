package main;
use strict;
use warnings;

sub first_unique_char {
    my $what = shift;
    my %seen_chars;

    my $pos = 0;

    while ( $pos < length($what) ) {
        my $char = substr( $what, $pos, 1 );
        return $char
            if ( index( $what, $char, $pos + 1 ) == -1 )
            and ( not exists( $seen_chars{$char} ) );

  # This is needed for the case LL, otherwise it would not detect the second L
        $seen_chars{$char} = 1;
        $pos++;
    }
    return '';
}

use Test::More;

is( first_unique_char("Perl Weekly Challenge"), "P" );

is( first_unique_char("Long Live Perl"), "o" );

is( first_unique_char("LL"), "" );

done_testing;

1;
