#!/usr/bin/env raku

constant @SPARKS = <<▁ ▂ ▃ ▄ ▅ ▆ ▇ █>>;

#| Draw a sparkline for the given list of positive numbers
sub MAIN( *@values where { all(@values).Num() >= 0 } ) {
    my &func = sub ($) { 3 };
    my ( $min, $max ) = ( @values.min, @values.max );
    if ( $min != $max ) {
        my $break =  (($max - $min) / 7);
        &func = sub ($v) { Int( ($v - $min) / $break ) }
    }
    @values.map( &func ).map( { @SPARKS[$_] } ).join('').say;
}

multi sub spark-points( $min, $max ) {
    return( 0, (($max - $min) / 8) );
}
