#!raku

sub MAIN( Int $N where { $N >= 10 } ) {
    my @digits = $N.split( '' );
    my @squares = @digits.map: { $_ * $_ };
    say 1 if @squares.sum.sqrt == @squares.sum.sqrt.Int;
}
