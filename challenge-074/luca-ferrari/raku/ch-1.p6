#!raku

# % raku ch-1.p6 1 2 2 3 2 4 2
# 2
#
# % raku ch-1.p6 1 3 1 2 4 5
# -1

sub MAIN( *@array where { @array.grep( * ~~ Int ).elems == @array.elems } ) {
    my $N = @array.elems;
    my $majority = floor( $N / 2 );

    my %counting;
    %counting{ $_ }++ for @array;

    given %counting.pairs.map( { .value >= $majority ?? $_ !! Nil } ).grep( * ~~ Pair ).unique.head {
        when .so { .key.say; }
        default  { '-1'.say; }
    }
}
