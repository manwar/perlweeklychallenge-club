#!/usr/bin/env raku

#| Given a matrix of 0's and 1's make any row or column with a 0 in all 0's
sub MAIN (
    UInt :h(:$height)!, #= Height of matrix
    UInt :w(:$width)!, #= Width of matrix
    *@values where { 
                     ( @values.elems == $height * $width ) &&
                     ( so all(@values.map( 0|1 == * ) ) )
                   }, #= Matrix of 0's and 1's
) {
    my @matrix = @values.rotor($width);
    say "Before:";
    format-matrix( @matrix ).say;
    say "After:";
    format-matrix( process-matrix( $height, $width, @matrix ) ).say;
    #    @matrix.rotor($width).map( *.join(" ") ).join("\n").say;
}

sub format-matrix( @matrix ) {
    @matrix.map( *.join(" ") ).join("\n");
}

sub process-matrix( $height, $width, @matrix ) {
    my @output = [1 xx $width] xx $height;
    for ^$height -> $y {
        for ^$width -> $x {
            if (@matrix[$y][$x] == 0) {
                @output[$y] = [0 xx $width];
                for ^$height -> $yo {
                    @output[$yo][$x] = 0;
                }
            }
        }
    }
    return @output;
}
