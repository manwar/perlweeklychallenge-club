#!raku

sub MAIN( Int $x is copy where { $x > 0 },
          Int $y is copy where { $y > 0 },
          Bool :$verbose = False ) {

    my @status;
    my $step = 0;
    while ( $x > 0 && $y > 0 ) {
        $x = $x - $y and @status.push( [ $x, $y ] ) if $x >= $y;
        $y = $y - $x and @status.push( [ $x, $y ] ) if $y >= $x;
    }

    @status.push: [ $x, $y ] if ( $x + $y != 0 && any( $x, $y ) == 0 );
    
    @status.join( "\n" ).say if $verbose;
    @status.elems.say;
}
