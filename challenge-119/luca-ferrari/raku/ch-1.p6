#!raku


sub MAIN( Int $N where { $N < 256 && $N >= 0 } ) {

    # create an 8 digits binary string
    '%08d'.sprintf( $N.base( 2 ) )
    # separate each digit into an array
    .split( '', :skip-empty )
    # rotate by four elements
    .rotate( 4 )
    # recombine
    .join
    # reparse as binary
    .Str
    .parse-base( 2 )
    # and print
    .say;

}
