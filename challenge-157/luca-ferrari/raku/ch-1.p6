#!raku

sub MAIN( *@n where { @n.elems > 0 && @n.grep( * ~~ Int ) == @n.elems } ) {
    my $am = @n.sum / @n.elems;
    my $gm = ( [*] @n ) ** ( 1 / @n.elems.Rat );
    my $hm = @n.elems / @n.map( 1/* ).sum;

    "AM = $am GM = $gm HM = $hm".say;
}
