#!/usr/bin/env raku

use v6;

my $*SUB-MAIN-OPTS = ( named-anywhere => True );

#| Given a width and a set of 0's and 1's return the number of squares in the grid with 1's in each corner
sub MAIN(
    UInt $width, #= Width of the grid
    *@input where { (any(1,0) == all(@input)) && (@input.elems %% $width) }, #= List of 0's and 1's to make the grid
    Bool :v(:$verbose) = False, #= Print the Grid as well as the count of squares
) {
    my @grid = @input.rotor($width);
    my $height = @grid.elems;
    my $count = 0;

    if $verbose { .join(" ").say for @grid } 
    
    for 0..$width-2 -> $x {
        for 0..$height-2 -> $y {
            my $max = $width - $x < $height - $y ?? $width - $x - 1 !! $height - $y - 1;
            for 1..$max -> $sq_width {
                $count++ if check-square( @grid, $x, $y, $sq_width );
            }            
        }
    }
    say $count;
}

sub check-square( @grid, $x, $y, $width ) {
    so all(
        @grid[$y][$x],
        @grid[$y][$x+$width],
        @grid[$y+$width][$x],
        @grid[$y+$width][$x+$width],
    ) == 1;
}
