#!/usr/bin/env raku
# -*- Mode: Raku; indent-tabs-mode: nil; coding: utf-8 -*-
# vim: set et ts=4 sw=4:

use v6.d;

# solution
class Rect {
    has ( @.x, $.h );
    method x-range() {  (min @!x) .. (max @!x) }
    method area () {
        $!h * (@!x.elems == 1 ?? 1 !! 1 + abs( [-] @!x ) )
    }
}

sub all-possible-rect ( @H ) {
    ( ^@H.elems ).combinations( 1..2 ).map(
        -> @range {
            Rect.new( :x(@range),
                      :h( @H[ min(@range) .. max(@range) ].min ) );
        } );
}

sub get-largest-ares ( Rect:D @rects ) {
    @rects.map( *.area ).max;
}

sub ssprintf ( UInt:D $w, $str ) { sprintf( "%#{$w}s", $str ) }

# bonus
sub print-histogram ( :histogram-data(@H), :all-rects(@rects) ) {
    my $max-area   = get-largest-ares( @rects );
    my @ma-rects   = @rects.grep( -> $r { $r.area == $max-area } );
    my $mh = max @H;
    my $ww = $mh.chars + 1;
    for $mh ... 1 -> $y {
        my $line = ssprintf( $ww, $y ) ~ '│';
        for 0 .. @H.end Z @H -> ($i, $h) {
            my $ch = " ";
            if $h >= $y {
                $ch = "#";
                for @ma-rects -> $r {
                    $ch = "■" if $r.h >= $y and $i (elem) $r.x-range;
                }
            }
            $line ~= ssprintf( $ww, $ch );
        }
        $line.say;
    }
    say ssprintf( $ww, " " ) ~ '└' ~ ( "─" x ( $ww * @H.elems ) );
    say ssprintf( $ww, " " ) ~ ' ' ~ [~] @H.map( -> $h { ssprintf( $ww, $h ) });
}

sub MAIN ( **@H where { @H.elems > 0 and @H.all ~~ UInt } ) {
    @H = @H>>.UInt;
    my Rect @rects = all-possible-rect( Array[UInt].new(@H) );
    my $largest = get-largest-ares( @rects );
    say "Input: {@H.raku}";
    say "Output: {$largest}";
    say "Where:";
    print-histogram( :histogram-data(@H), :all-rects( @rects ) );
}
