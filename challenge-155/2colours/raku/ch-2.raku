#!/usr/bin/env raku

sub pisano-period($n) {
  0, 1, (* + *) % $n ... *
    andthen .rotor(2 => -1)
    andthen [\,] $_
    andthen .toggle: !*.repeated(:with(&[eqv]))
    andthen .tail
    andthen .map(*[0])
}

my @period = pisano-period 3;
say "π(3) = {+@period}\nThe period is: {@period.join: ', '}";
