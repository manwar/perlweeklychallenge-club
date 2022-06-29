#!raku

# Perl Weekly Challenge 171

sub compose( Sub:D $f, Sub:D $g ) {
    return sub (*@a) {
        "F( G( { @a } ) )".say;
        $f( $g( @a ) )
    };
}

sub MAIN() {
    my $f = sub (*@a) {
        "F( { @a } )".say;
        return @a;
    };
    my $g = sub (*@a) {
        "G( { @a } )".say;
        return @a;
    };

    my $h = compose( $f, $g );
    $h( 'PWC 171' );
}
