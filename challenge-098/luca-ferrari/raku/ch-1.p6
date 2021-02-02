#!raku


sub readN( Str $file-name, Int $how-many-chars where { $how-many-chars >= 1 } ) {
    state %handles = ();
    %handles{ $file-name } //= $file-name.IO.open;
    return %handles{ $file-name }.readchars: $how-many-chars;
}

sub MAIN( Str $file-name ) {
    say readN( $file-name, 4 );
    say readN( $file-name, 4 );
    say readN( '/home/luca/.zshrc', 10 );
}
