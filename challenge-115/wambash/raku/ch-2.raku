#!/usr/bin/env raku


sub largest-multiple (+@n) {
    with @n.grep(* %% 2).min -> $min-even {
        @n.Bag ∖ $min-even
        andthen .kxxv.sort.reverse
        andthen .join ~ $min-even
    }
}


multi MAIN (:test($)!) {
    use Test;
    is largest-multiple(1,0,2,6), 6210;
    is largest-multiple(1,4,2,8), 8412;
    is largest-multiple(1,4,7,6), 7614;
    is largest-multiple(1,4,7,4), 7414;
    is largest-multiple(1,3,7,9), '9731Inf';
    done-testing;
}

multi MAIN (*@n) {
    say largest-multiple @n;
}
