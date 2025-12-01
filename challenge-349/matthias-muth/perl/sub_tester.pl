#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 349 Task 2: Meeting Point
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use builtin qw( true false );

sub meeting_point_subs( $path ) {
    my ( $x, $y ) = ( 0, 0 );
    state %move_subs = (
        U => sub { ++$y },
        D => sub { --$y },
        L => sub { --$x },
        R => sub { ++$x },
    );

    $x+=20; $y +=20;
    for ( split "", $path ) {
        $move_subs{$_}->();
        say "$_->($x,$y)";
        return true
            if $x == 0 && $y == 0;
    }
    return false;
}

meeting_point_subs( "UUUUDDDLLLLLLLRRR" );

