#!/usr/bin/env raku

constant @Bell-triangle = [1], { [ [\+] .tail, |$_ ] } ... *;
constant @Bell-numbers  = @Bell-triangle.map: *.head;

multi MAIN ( $n = 10 ) {
    .say for @Bell-numbers.head($n)
}

multi MAIN (Bool :$test!) {
    use Test;

    is @Bell-triangle[5], <52    67    87   114   151   203>;
    is @Bell-numbers.head(10), (1, 1, 2, 5, 15, 52, 203, 877, 4140, 21147);

    done-testing;
}
