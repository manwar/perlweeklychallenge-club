use v6;

sub min-sliding-window (@a, $s) {
    @a
    andthen .rotor: $s => - $s.pred
    andthen .map: *.min
}

sub MAIN ( :$test! ) {
    use Test;
    is min-sliding-window((1, 5, 0, 2, 9, 3, 7, 6, 4, 8),3),  (0, 0, 0, 2, 3, 3, 4, 4);
    done-testing();
}
