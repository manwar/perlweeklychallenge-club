#!raku

sub MAIN( Int $n where { $n > 1 }, Bool :$verbose = True ) {
    for ( 2 .. $n - 2 ) {
        my $bag = $n.base( $_ ).comb.Bag;
        '1'.say and exit if $bag.keys.elems == 1;
    }

    '0'.say;
}
