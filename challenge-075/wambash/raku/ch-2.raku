use v6;

sub largest-rectangle-histogram (+@a) {
    @a, *.skip ...^ :!elems
    andthen .map: {
        $_.cache
        andthen [\min] $_
        andthen 1..* Z* $_
        andthen .max
    } andthen .max
}

sub MAIN (:$test!) {
    use Test;
    is largest-rectangle-histogram( 2, 1, 4, 5, 3, 7 ), 12;
    is largest-rectangle-histogram( 3, 2, 3, 5, 7, 5 ), 15;
    done-testing();
}
