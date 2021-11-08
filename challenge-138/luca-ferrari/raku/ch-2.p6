#!raku

sub MAIN( Int:D $n where { $n > 0 } ) {
    my $qrt = $n.sqrt;
    my @digits = $n.split( '', :skip-empty );

    # short circuit: esay case
    1.say and exit if @digits.sum == $qrt;

    # try to aggregate from left to right
    for 1 ..^ @digits.elems {
        last if @digits[ 0 .. $_ ].join.Int > $qrt;
        '1'.say and exit if @digits[ 0 .. $_ ].join + @digits[ $_ + 1 .. * - 1 ].sum == $qrt;
    }
    
}
