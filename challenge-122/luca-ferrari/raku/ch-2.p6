#!raku

sub MAIN( Int $S ) {
    my @available-points = 1, 2, 3;
    my $begin = ( @available-points[ 0 ] x $S ).Int;
    my $end   = ( @available-points[ * - 1 ] x $S ).Int;
    my @scores;


        for ( $begin .. $end ) {
            my @digits = $_.split( '', :skip-empty ).grep( * == any( @available-points ) );
            next if ! @digits.grep: $_ for @available-points;
            next if @digits.sum != $S;
            my $score =  @digits.grep( * == any( @available-points ) ).join;;
            @scores.push: $score if ( ! @scores.grep( $score ) );

        }


    @scores.join( "\n" ).say;
}
