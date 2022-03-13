#!/usr/bin/env raku
constant @fib = 0,1, * + * ... *;

sub pisano-period ($n) {
   my @fb = @fib.map: * mod $n;

   1..$n²
   andthen .first: {
       |@fb.head( $^k) xx (($n² div $^k) + 1)
       eqv
        @fb.head: $^k  *  (($n² div $^k) + 1)
   }
}

multi MAIN (Bool :test($)!) {
    use Test;
    is pisano-period( 3),  8;
    is pisano-period( 4),  6;
    is pisano-period( 9), 24;
    is pisano-period(25),100;
    done-testing;
}

multi MAIN ($n) {
    say pisano-period $n
}
