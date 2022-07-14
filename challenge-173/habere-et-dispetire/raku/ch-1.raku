#! /usr/bin/env raku

# Esthetic Number
# https://oeis.org/A033075

sub is-esthetic ( $n ) {

    $n.comb
      .rotor( 2 => -1 )
      .flat
      .map( (* - *).abs == 1 )
      .all
      .so

}
