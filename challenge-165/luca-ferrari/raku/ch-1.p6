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
            my $point = circle =>  [ cx => @elements[ 0 ].Num,
                                     cy => @elements[ 1 ].Num,
                                     r => 5,
                                     fill => 'blue' ];
            @points.push: $point;
        }
        else {
            # a line
            my $line = line => [ x1 => @elements[ 0 ].Num,
                                 y1 => @elements[ 1 ].Num,
                                 x2 => @elements[ 3 ].Num,
                                 y2 => @elements[ 3 ].Num,
                                 stroke => 'magenta' ];
            @lines.push: $line;
        }

    }

    $filename.IO.spurt( SVG.serialize:
            svg => [ width => 500, height => 500, |@points, |@lines ] );
}
