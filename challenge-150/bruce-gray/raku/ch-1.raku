sub task1 ( Str $s1, Str $s2, UInt $n ) {
    return ( $s1, $s2, * ~ * … {.chars >= $n} ).tail.substr($n-1, 1);
}
multi sub MAIN ( $a, $b ) {
    say task1( $a, $b, 51 );
}
multi sub MAIN ( ) {
    use Test;
    plan 1;
    is task1( |<1234 5678>, 51 ), '7', '51st char of Fib_substr(1234 5678) is "7"';
}
