#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

say jump_game( 1, 2, 1, 2 );
say jump_game( 2, 1, 1, 0, 2 );
say jump_game( 1, 9, 9, 2 );

sub jump_game( @n ) {
    say join ' ', ' ', @n;
    my $i = 0;
    while (1) {
        if ( !defined $n[$i] )                         { last }
        if ( $n[$i] == 0 )                             { last }
        if ( defined $n[$i] && !defined $n[ $i + 1 ] ) { return 1 }
        $i += $n[$i];
    }
    return 0;
}
