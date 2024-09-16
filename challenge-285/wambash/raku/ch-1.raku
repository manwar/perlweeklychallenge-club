#!/usr/bin/env raku

multi no_connection (+@ ($from, $to)) {  $to  }
multi no_connection (+@routes) {
    my :(@from, @to) := [Z] @routes;

    @to.first: { $_ ∉ @from }
}

multi MAIN (Bool :test($)!) {
    use Test;
    is no_connection(<B C>, <D B>, <C A>), 'A';
    is no_connection(<A Z>), 'Z';
    done-testing;
}

multi MAIN (+@routes) {
    say no_connection +@routes
}
