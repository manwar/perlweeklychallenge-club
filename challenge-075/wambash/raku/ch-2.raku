use v6;

sub largest-rectangle-histogram-from-start (+@a) {
    @a
    andthen [\min] $_
    andthen 1..* Z* $_
    andthen .max
}

sub largest-rectangle-histogram (+@a) {
    @a, *.skip ...^ :!elems
    andthen .map: &largest-rectangle-histogram-from-start
    andthen .max
}

sub MAIN (:$test!) {
    use Test;
    is largest-rectangle-histogram( 2, 1, 4, 5, 3, 7, ), 12;
    is largest-rectangle-histogram( 3, 2, 3, 5, 7, 5, 0 ), 15;
    is largest-rectangle-histogram(1,2,3,4,5,6,3,3,4,3,3,3,1), 30;
    done-testing();
}
