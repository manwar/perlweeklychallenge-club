#!/usr/bin/env raku

sub binary-flip ($n) {
   $n
   andthen .base(2)
   andthen .trans: <0 1> => <1 0>
   andthen :2( $_ )
}

multi MAIN (Bool :test($)!) {
    use Test;
    is binary-flip(5),2;
    is binary-flip(4),3;
    is binary-flip(6),1;
    done-testing;
}

multi MAIN ($n) {
    say binary-flip $n
}
