#!raku

# Perl Weekly Challenge 163

sub MAIN( *@n where { @n.grep( * ~~ Int ).elems == @n.elems } ) {
    my $sum = 0;
    $sum += ( @n[ $_ - 1 ].base( 2 ) +& @n[ $_ ].base( 2 ) ).Str.parse-base( 2 ) for 1 ..^ @n.elems;
    $sum += ( @n[ 0 ].base( 2 ) +& @n[ * - 1 ].base( 2 ) ).Str.parse-base( 2 );
    $sum.say;
}
