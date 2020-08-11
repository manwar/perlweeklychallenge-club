#!/usr/bin/env raku

use v6.d;

#| Find the path from the top right of the grid to the
#| Bottom left that sums up to the least amount.
sub MAIN (
    UInt $width, #= Width of the grid
    *@cells where { $_.all ~~ UInt && 1 < $_.elems && $_.elems %% $width }, #= Cell values 
    Bool :v(:$verbose) = False, #= Verbose mode
) {
    my @grid = @cells.rotor($width);
    say "Width: $width\nGrid:" if $verbose;
    say @grid.map( { .join(" ") } ).join("\n") if $verbose;

    my @short-route = route-to( (0,0), (@grid[0].end,@grid.end) ).sort( -> @route { score-route( @grid, @route ) } )[0];
    
    @short-route[0].map( -> ($x,$y) { @grid[$y][$x] } ).join(" -> " ).say if $verbose;
    
    say score-route( @grid, @short-route[0] );
}

multi sub score-route( @grid, @route ) {
    [+] @route.map( -> ( $x, $y ) { @grid[$y][$x] } );
}

multi sub route-to ( @s, @e where { @s ~~ @e } ) { return [ [@s,], ] }

multi sub route-to( @s, @e ) {
    my @routes;
    if ( @s[0] !~~ @e[0] ) {
        for route-to( ( @s[0]+1, @s[1] ), @e ) -> @route {
            @routes.push( @route.unshift( @s ) );
        }
    }
    if ( @s[1] !~~ @e[1] ) {
        for route-to( ( @s[0], @s[1]+1 ), @e ) -> @route {
            @routes.push( @route.unshift( @s ) );
        }
    }
    @routes;
}
