#!/usr/bin/env raku

constant SYM = '♀';

multi sub MAIN( 1 ) is hidden-from-USAGE { say SYM }

#| Given a radius for the circle draw the Female Symbol
multi sub MAIN(
    UInt $rad where * <= 20 #= Radius from 1 to 20
) {
    draw-circle( $rad );
    draw-cross( $rad );
}

sub draw-circle( \rad ) {
    # Totally nicked this from here : https://stackoverflow.com/questions/1022178/how-to-make-a-circle-on-a-grid
    my \grid-size = (rad * 2)+1;
    my @grid = [ [ " " xx grid-size ] xx grid-size ];
    my Int $x = 0;
    my Int $y = rad;
    my Int $d = 3 - (2 * rad);
    my \c = rad;
    repeat {
        @grid[c+$y][c+$x] = SYM;
        @grid[c-$y][c+$x] = SYM;
        @grid[c-$y][c-$x] = SYM;
        @grid[c+$y][c-$x] = SYM;
        @grid[c+$x][c+$y] = SYM;
        @grid[c-$x][c+$y] = SYM;
        @grid[c-$x][c-$y] = SYM;
        @grid[c+$x][c-$y] = SYM;
        if ( $d < 0 ) {
            $d = $d + (4 * $x) + 6
        } else {
            $d = $d + 4 * ( $x - $y) + 10;
            $y--;
        }
        $x++;
    } while ($x <= $y);
    .say for @grid.map( *.join("") );
}

sub draw-cross( \rad ) {
    (" " x rad ~ SYM).say for 1..^rad;
    (" " ~ (SYM x (rad*2)-1)).say;
    (" " x rad ~ SYM).say for 1..^rad;    
}
