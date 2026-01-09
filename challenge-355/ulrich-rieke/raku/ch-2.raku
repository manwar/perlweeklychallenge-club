use v6 ;

say "Enter some integers separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $result ;
if ( @numbers.elems < 3 ) {
    $result = False ;
}
else {
    my $maxint = @numbers.max ;
    my @maxplaces ; # where do we find $maxint ?
    for (0..@numbers.elems - 1 ) -> $i {
        if ( @numbers[$i] == $maxint ) {
            @maxplaces.push( $i ) ;
        }
    }
#there should be only one maximum, and it should be somewhere in the
#middle of the array
    if ( @maxplaces.elems > 1 || @maxplaces[0] == 0 || @maxplaces[0]
            == @numbers.elems - 1 ) {
        $result = False ;
    }
    else {
        my @risingDifferences ; #differences up to the maximum
        for (0..@maxplaces[0] - 1) -> $i {
            @risingDifferences.push( @numbers[$i] - @numbers[$i + 1] ) ;
        }
        my @fallingDifferences ; #differences from the maximum to the end
        for (@maxplaces[0]..@numbers.elems - 2) -> $i {
            @fallingDifferences.push( @numbers[$i] - @numbers[$i + 1] ) ;
        }
        $result = (so @risingDifferences.all < 0  && so @fallingDifferences.all 
            > 0 ) ;
    }
}
say $result ;
