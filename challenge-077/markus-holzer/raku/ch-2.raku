unit sub MAIN( $input-file );

my @input = $input-file.IO.lines.map: *.comb;

dd ( ^@input X ^@input.head ).grep( -> ($x, $y) { 
    @input[$x;$y] eq "X" && @input.&stands-alone($x, $y) });

sub stands-alone( $matrix, $x, $y ) {
    state @maybe-neighbours = (-1,-1), (-1,0), (-1,1), (0,-1), (0, 1), (1,-1), (1,0), (1,1);

    sub is-neighbour($c) { 
	$matrix[ $x + $c[0]; $y + $c[1] ] andthen $_ eq "X" }

    @maybe-neighbours.grep( &is-neighbour ) == 0 }