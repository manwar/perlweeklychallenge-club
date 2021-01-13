#!/usr/bin/env raku
# -*- Mode: Raku; indent-tabs-mode: nil; coding: utf-8 -*-
# vim: set et ts=4 sw=4:

use v6.d;

sub USAGE {
    say q:to{__USAGE__};
Usage:
    echo -e "[a b c][d e f][g h i]" | raku ch-2.raku
    or input ending with EOF (Ctrl-D or Ctrl-Z)
    (you might need to filter the STDERR to get only answer)
__USAGE__
}

unit sub MAIN;

$*ERR.say("Input: (Ctrl-D or Ctrl-Z to finish to input.)");
my @matrix = do with my @lines = $*IN.lines {
    @lines = @lines.
    split(/"]" \s* "\n"* || "\n"/).    # split rows by newline or `]'
    map( -> $ln { next if $ln eq "";
                  (S:g/ ^\s+ || '[' || \s+$ // with $ln).
                  split(/\s+/).Array } );

    if @lines[0] ~~ Array and @lines[0][0] ne "" {
        @lines
    } else {
        < 1  2  3  4>,
        < 5  6  7  8>,
        < 9 10 11 12>,
        <13 14 15 16>  # example 2
    }
}

# confirm user input
my $ww = @matrix>>.List.flat.max(*.chars).chars;

#$*ERR.say( "given matrix: " );
#$*ERR.say( .map({sprintf("%*s", $ww, $_)}).Array ) for @matrix;
#$*ERR.say;

sub peel-off( @a ) {
    my ( $re, $ce ) = @a.end, @a[0].end;

    my @inside  = @a[ 1 .. $re.pred; 1 .. $ce.pred ] // Empty;
    @inside .= rotor($ce.pred).map(*.Array) if @inside;

    my @outside = @a[ 0; * ];                           # outside of top

    for ( [ 1 .. $re;     $ce         ],                # outside of right
          [ $re;          $ce.pred,
                          $ce.pred.
                           pred ... 0 ],                # outside of bottom
          [ $re.pred,
            $re.pred.
             pred ... 1;   0         ]  )               # outside of left
    -> ( $rr, $cr ) {
        last unless all( $rr.elems.so, $cr.elems.so );  # out of range
        @outside.append: @a[$rr[*]; $cr[*]];
    }
    @inside, @outside
}

my @spiral;
my @mat = @matrix.clone;

my ( $in, $out );
repeat {
    ( $in, $out ) = peel-off( @mat );
    @spiral.append: |$out;
    @mat = |$in;

} while ( @mat[0] andthen { .elems > 0} );

@spiral.put;
