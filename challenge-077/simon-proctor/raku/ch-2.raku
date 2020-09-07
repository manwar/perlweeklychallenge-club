#!/usr/bin/env raku

use v6;

my %*SUB-MAIN-OPTS = :named-anywhere;

#| Given a width and a list of O and X's
#| Makes a grid of the given width and counts the number of X's not touching any others
sub MAIN(
    UInt $width, #= Width of the grid
    :v(:$verbose) = False, #= Prints the Grid
    *@cells where { "O"|"X" ~~ $_.all && $_.elems %% $width && $_.elems >= $width }
) {
    my @grid = @cells.rotor($width);
    @grid.map( *.join(" ")).join("\n").say if $verbose;

    my $count = 0;
    for (0..^$width X, 0..^@grid.elems) -> @vec {
        $count++ if @grid[@vec[1]][@vec[0]] ~~ "X" ~~ none(surrounding-cells( @vec, @grid ));
    }
    say $count;
}

sub surrounds( @vec ) {
    (-1..1 X, -1..1).grep( { ! ( $_[0] == $_[1] == 0 ) } ).map( { [ $_[0]+@vec[0], $_[1]+@vec[1] ] } ).grep( { $_[0]&$_[1] >= 0 } );
}

sub surrounding-cells( @vec, @grid ) {
    surrounds(@vec).map( -> ($x,$y) { @grid[$y][$x] } ).grep( { defined $_ } );
}
