#!/usr/bin/env raku

sub common-base-string ( $a, $b ) {
    $a.match(/
        ^ (.+)  $0* $
        <?{
        with $0 {
             $b.match: / ^ "$_"+ $ /
        }
        }>
        /,
        :ex
    );
    $/.map: *.[0].Str
}

multi MAIN ( $a, $b ) {
    say common-base-string($a, $b);
}

multi MAIN ( :$test ) {
    use Test;
    is common-base-string( 'abcdabcd', 'abcdabcdabcdabcd' ), <abcdabcd abcd>;
    is common-base-string( 'aaa', 'aa' ), < a >;
    done-testing;
}
