#!raku

# Perl Weekly Challenge 165

use SVG;
sub MAIN( Str $filename = 'task1.svg' ) {
    my ( @points, @lines );

    for $*IN.lines() -> $line {
        my @elements = $line.split(',').map( *.trim );
        next if @elements.elems !%% 2 && @elements.elems !%% 4;

        if @elements.elems == 2 {
            # a point
            my $point = circle =>  [ cx => @elements[ 0 ].Int,
                                     cy => @elements[ 1 ].Int,
                                     r => 5,
                                     fill => 'blue' ];
            @points.push: $point;
        }
        else {
            # a line
            my $line = line => [ x1 => @elements[ 0 ].Int,
                                 y1 => @elements[ 1 ].Int,
                                 x2 => @elements[ 3 ].Int,
                                 y2 => @elements[ 3 ].Int,
                                 stroke => 'magenta' ];
            @lines.push: $line;
        }

    }

    $filename.IO.spurt( SVG.serialize:
            svg => [ width => 100, height => 100, |@points, |@lines ] );
}
