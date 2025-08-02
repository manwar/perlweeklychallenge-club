#!raku

#
# Perl Weekly Challenge 288
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-288>
#

sub mark-visited( @positions, $r, $c ) {
    @positions.push: [ $r, $c ] if ( ! @positions.grep( { $_[ 0 ] == $r && $_[ 1 ] == $c } ) );

}


sub MAIN() {
    my $matrix = [
	['x', 'x', 'x', 'x', 'o'],
	['x', 'o', 'o', 'o', 'o'],
	['x', 'o', 'o', 'o', 'o'],
	['x', 'x', 'x', 'o', 'o'],
    ];

    # get all the information about every cell
    # keyed by the cell content
    my %cells = x => Array.new, o => Array.new;

    for 0 ..^ $matrix.elems -> $row {
	for 0 ..^ $matrix[ $row ].elems -> $col {
	    my $id = $row ~ '-' ~ $col;
	    my $key = $matrix[ $row ][ $col ];
	    mark-visited( %cells{ $key }, $row, $col ) if ( $matrix[ $row ][ $col ] eq $key );
	    # adiacent nodes
	    my ( $nr, $nc ) = $row, $col;
	    $nr = $row + 1;
	    mark-visited( %cells{ $key }, $nr, $nc ) if ( $nr >= 0 && $nr < $matrix.elems && $matrix[ $nr ][ $nc ] eq $key );
	    $nr = $row - 1;
	    mark-visited( %cells{ $key }, $nr, $nc ) if ( $nr >= 0 && $nr < $matrix.elems && $matrix[ $nr ][ $nc ] eq $key );
	    $nr = $row;
	    $nc++;
	    mark-visited( %cells{ $key }, $nr, $nc ) if ( $nc >= 0 && $nc < $matrix[ 0 ].elems && $matrix[ $nr ][ $nc ] eq $key );
	    $nc = $col - 1;
	    mark-visited( %cells{ $key }, $nr, $nc ) if ( $nc >= 0 && $nc < $matrix[ 0 ].elems && $matrix[ $nr ][ $nc ] eq $key );
	}
    }

    "$_ = { %cells{ $_ }.flat.elems }".say for %cells.keys;
}
