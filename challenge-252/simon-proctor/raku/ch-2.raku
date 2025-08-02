#!/usr/bin/env raku

#| Run test suite
multi MAIN('test') {
    use Test;
    is number-list(4), (-2,-1,1,2);
    for (1..10) -> $n {
        is ([+] number-list($n)), 0;
    }
    done-testing;
}

#| give a list of unqiue integers that add up to zero
multi sub MAIN(
    $n where Int #= List length
) {
    number-list($n).join(', ').say;
}

multi sub number-list( $n where $n %% 2 ) {
    my $p = $n div 2;
    my @neg = (-$p..^0).list;
    my @pos = @neg.map(* * -1);
    ( |@neg, |@pos ).sort; 
}

multi sub number-list($n) {
    ( |number-list($n-1), 0 ).sort;
}
