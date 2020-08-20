#!/usr/bin/env raku
# -*- Mode: Raku; indent-tabs-mode: nil; coding: utf-8 -*-
# vim: set et ts=4 sw=4:

use v6.d;

# solution
sub get-major ( Int @list ) {
    given @list.elems {
        when 0 { -1.return }
        when 1 { @list.first.return }
    }

    my @sorted = @list.sort;
    my $half-len = @sorted.elems * 0.5 .floor;
    my ( $pnum, $pcnt, $res ) = @sorted.shift, 1, -1;

    for @sorted -> $cnum {
        if $pnum == $cnum { if ++$pcnt > $half-len { $res = $cnum, last } }
        else { ( $pnum, $pcnt ) = ( $cnum, 1 );     }
    }
    $res
}

# testing
sub MAIN ( \S where * > 0 = 10 #= sample size
       ) {
    my $ensure-major = Bool.pick;
    my $major-number = S.rand .floor;
    my $half-length  = .5 * S .floor;

    my @sample = $ensure-major ?? ( flat $major-number xx ( $half-length+1 )
                                  , | (0..S).pick( $half-length-1 ) )
                              !! (0..S).pick(S);
    my $major = get-major( Array[Int].new( @sample ) );
    say "Sample: {@sample.raku}";
    say "Major : $major";
}
