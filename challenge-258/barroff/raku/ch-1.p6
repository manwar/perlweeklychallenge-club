#!/usr/bin/env raku

use v6.d;

sub count-even-digits-number(@ints --> Int:D) {
    sum(map({ not( Str($_).chars % 2 ).Int  }, @ints));
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is count-even-digits-number(( 10, 1, 111, 24, 1000 )), 3, 'works for ( 10, 1, 111, 24, 1000 )';
    is count-even-digits-number(( 111, 1, 11111 )), 0, 'works for ( 111, 1, 11111 )';
    is count-even-digits-number(( 2, 8, 1024, 256 )), 1, 'works for ( 2, 8, 1024, 256 )';
}

#| Take user provided number like 10 1 111 24 1000
multi sub MAIN(Int:D @ints) {
    say count-even-digits-number(@ints);
}
