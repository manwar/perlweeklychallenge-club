#!/usr/bin/env raku

use v6;

#! Given a width and a list of 0's and 1's find the biggest rectangle of 1's
#| found within the grid of the given width
sub MAIN (
    UInt $width, #= Width of the grid
    *@G where { ($_.all == 0|1) && ($_.elems %% $width) } #= 0's and 1's to make grid
) {
    my $height = @G.elems / $width;

    my @options;
    for 0..^$width -> $x {
        for 0..^$height -> $y {
            for 1..$width-$x -> $w {
                for 1..$height-$y -> $h {
                    @options.push( { :$x, :$y, :$w, :$h } );
                }
            }
        }
    }
    for @options.sort( { $^b<w> * $^b<h> <=> $^a<w> * $^a<h> } ) -> %o {
        my @res = @G[rect(:$width, |%o)];
        if all(@res) == 1 {
            @res.rotor(%o<w>).map( *.join(" ")).join("\n").say;
            exit;
        }
    }
    say 0;
}

sub rect(UInt :$width, UInt :$x, UInt :$y, UInt :$w, UInt :$h) {
    my @o;
    for 0..^$h -> $dy {
        my $s = $x + ( ( $y + $dy ) * $width );  
        @o.push( |($s..^$s+$w) );
    }
    return @o;
}
