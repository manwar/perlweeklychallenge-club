#!raku

sub MAIN( *@numbers where { @numbers.grep( * ~~ Int ).elems == @numbers.elems
                                                                && ! @numbers.grep( *.Int < 0 ) } ) {

    my $degree = Bag.new( @numbers ).values.max;
    say $degree;

    for 2 .. @numbers.elems {
        my @list = @numbers.rotor( $_ => -1 * ( $_ -1 ) );
        for @list -> $current {
            $current.say and exit if Bag.new( $current.Array ).values.max == $degree;
        }
    }
}
