#!/usr/bin/env raku

use v6;

my %*SUB-MAIN-OPTS = :named-anywhere;

#| Given a list of height find the area of the largest single rectangle
sub MAIN (
    Bool :g(:$graph-heights) = False, #=Draw the height histogram first
    *@heights where { $_.all ~~ UInt && $_.elems >= 1 } , #= List of height
) {
    my $rect-details =  calculate-max-rect( @heights );
    draw-heights( @heights, $rect-details ) if $graph-heights;
    say $rect-details.area;
}

class RectDetails {
    has Range $.range;
    has UInt $.height;
    has UInt $.area;
}

sub draw-heights( @heights, $rect ) {
    my $max = @heights.max;
    my $width = $max.codes;
    my $bar = '#' x $width;
    my $spc = ' ' x $width;
    my $dsh = '-' x $width;
    my $rct = 'X' x $width;
    my &spr = -> $x { sprintf( "%{$width}d", $x ) }
    my &prt = -> $h {
        -> $k, $v {
            if ($k ~~ $rect.range) && ($h <= $rect.height) {
                $v >= $h ?? $rct !! $spc;
            } else {
                $v >= $h ?? $bar !! $spc;
            }
        };
    };
    
    for $max...1 -> $h {
        my &fnc = &prt($h);
        ( &spr( $h ),  |@heights.kv.map( &fnc ) ).join(" ").say;
    }
    ( $dsh xx @heights.elems + 1 ).join(" ").say;
    ( $spc, |@heights.map( &spr ) ).join(" ").say;
}

sub calculate-max-rect( @heights ) {
    my $length = @heights.elems - 1;

    my @ranges = ( (0..$length) X.. (0..$length) ).grep( { $_.min <= $_.max } );
    my $max = 0;
    my $result = RectDetails.new( area => 0 );

    for @ranges -> $range {
        my $height = @heights[$range.list].min;
        my $area = $height * ($range.max - $range.min + 1);
        $result = RectDetails.new( :$range, :$height, :$area ) if $result.area < $area;
    }
    return $result;
}
