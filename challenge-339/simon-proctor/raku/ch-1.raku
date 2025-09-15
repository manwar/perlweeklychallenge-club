#!/usr/bin/env raku

subset IsTrue of Bool where so *;

multi sub MAIN( IsTrue :t(:$test) ) is hidden-from-USAGE {
    use Test;
    is max-diff(5, 9, 3, 4, 6), 42;
    is max-diff(1, -2, 3, -4), 10;
    is max-diff(-3, -1, -2, -4), 10;
    is max-diff(10, 2, 0, 5, 1), 50;
    is max-diff(7, 8, 9, 10, 10), 44;
    is max-diff(1,-2,3,4), 14;
    is max-diff(1,2,3,4,5,6,-10),80;
    done-testing;    
}

multi sub MAIN( *@ints where Int() ~~ all(*) ) {
    max-diff( |@ints ).say;
}

multi sub max-diff( *@ints where all(@ints) >= 0 ) {
    my @sorted = @ints.sort;
    return (([*] @sorted.tail(2)) - ([*] @sorted.head(2)) );
}

multi sub max-diff( *@ints where all(@ints) <= 0 ) {
    my @sorted = @ints.sort;
    return (([*] @sorted.head(2)) - ([*] @sorted.tail(2)) );
}

multi sub max-diff( *@ints where *.elems > 4 ) {
    @ints.combinations(4).map( -> @l { max-diff(|@l) } ).max;
}

multi sub max-diff( Int $a, Int $b, Int $c, Int $d ) {
    ( ( ($a*$b)-($c*$d) ),
      ( ($c*$d)-($a*$b) ),
      ( ($a*$c)-($b*$d) ),
      ( ($b*$d)-($a*$c) ),
      ( ($a*$d)-($b*$c) ),
      ( ($b*$c)-($a*$d) ) ).max;
}
