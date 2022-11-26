#!/usr/bin/env raku

subset PosInt of Int where * > 0;

sub MAIN(PosInt $n) {
  $n.msb // 0 andthen
    2 +< $_ - 1 andthen
    $_ - $n andthen
    .say;    
}