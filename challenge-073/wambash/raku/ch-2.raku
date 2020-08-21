use v6;

sub smallest-neighbour ( +@a ) {
    @a
    andthen $_ Z=> .produce: &[min]
    andthen .map: { .key > .value ?? .value !! 0 }
}


sub MAIN ( :$test! ) {
    use Test;
    is smallest-neighbour(7, 8, 3, 12, 10),  (0, 7, 0, 3, 3);
    is smallest-neighbour(4, 6, 5),  (0, 4, 4);
    done-testing();
}
