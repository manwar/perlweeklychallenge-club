#!/usr/bin/env raku

use v6;

my %*SUB-MAIN-OPTS = :named-anywhere;

#| Given a list of height find the area of the largest single rectangle
sub MAIN (
    *@heights where { $_.all ~~ UInt && $_.elems >= 1 } , #= List of height
) {
    my @rain-levels =  calculate-rain-levels( @heights );
    draw-heights( @heights, @rain-levels );
    say [+] @rain-levels.map(*.area);
}

class RainArea {
    has Range $.range;
    has UInt $.height;
    has UInt $.area;
}

sub draw-heights( @heights, @rain ) {
    my $max = @heights.max;
    my $width = $max.codes;
    my $bar = '#' x $width;
    my $spc = ' ' x $width;
    my $dsh = '-' x $width;
    my $wtr = '~' x $width;
    my &spr = -> $x { sprintf( "%{$width}d", $x ) }
    my &prt = -> $h {
        -> $k, $v {
            my @found = @rain.grep( -> $r { $k ~~ $r.range } );
            if (@found && $h <= @found[0].height) {
                $v >= $h ?? $bar !! $wtr;
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

multi sub calculate-rain-levels( @heights where { any(@heights[0^..^*-1]) > any(@heights[0],@heights[*-1]) }, $offset = 0) {
    my $max = max(@heights[0^..^*-1]);
    my $mid-idx = @heights[0^..^*-1].kv.map( -> $k, $v { $v == $max ?? $k+1 !! Empty } )[0];
    
    return ( |calculate-rain-levels( @heights[0..$mid-idx],$offset ), |calculate-rain-levels( @heights[$mid-idx..*],$mid-idx+$offset ) )
}

multi sub calculate-rain-levels( @heights where { @heights.elems > 2 }, $offset=0 ) {
    my $height = min( @heights[0], @heights[*-1] );
    my $area = $height * ( @heights.elems - 2 );
    $area -= [+] @heights[0^..^*-1];
    return RainArea.new( range => ( $offset..^($offset+@heights.elems) ), :$area, :$height ); 
}

multi sub calculate-rain-levels(@,$) {}
