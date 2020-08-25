#!/usr/bin/env raku

use v6;

my %*SUB-MAIN-OPTS = :named-anywhere;

#| Given a list of height find the area of the largest single rectangle
sub MAIN (
    Bool :g(:$graph-heights) = False, #=Draw the height histogram first
    *@heights where { $_.all ~~ UInt && $_.elems >= 1 } , #= List of height
) {
    draw-heights( @heights ) if $graph-heights;
    say calculate-max-rect( @heights );
}

sub draw-heights( @heights ) {
    my $max = @heights.max;
    my $width = $max.codes;
    my $bar = '#' x $width;
    my $spc = ' ' x $width;
    my $dsh = '-' x $width;
    my &spr = -> $x { sprintf( "%{$width}d", $x ) }
    
    for $max...1 -> $h {
        ( &spr( $h ),  |@heights.map( { $_ >= $h ?? $bar !! $spc } ) ).join(" ").say;
    }
    ( $dsh xx @heights.elems + 1 ).join(" ").say;
    ( $spc, |@heights.map( &spr ) ).join(" ").say;
}

sub calculate-max-rect( @heights ) {
    my $length = @heights.elems - 1;

    my @ranges = ( (0..$length) X (0..$length) ).grep( { $_[0] <= $_[1] } );
    my $max = 0;

    for @ranges -> ($s,$e) {
        my $height = @heights[$s..$e].min;
        my $area = $height * ($e - $s + 1);
        $max = $area if $max < $area;
    }
    return $max;
}
