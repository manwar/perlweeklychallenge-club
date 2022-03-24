#!/usr/bin/env raku
use v6;
sub MAIN (*@args) {
   my @inputs = @args ?? @args !! (1, 3, 5, 6, 9);
   @inputs.say;
   "AM = %.1f, GM = %.1f, HM = %.1f\n".printf(
      arithmetic-mean(@inputs),
      geometric-mean(@inputs),
      harmonic-mean(@inputs)
   );
}

sub arithmetic-mean (@n) { @n.sum / @n.elems }
sub geometric-mean  (@n) { ([*] @n).abs ** (1 / @n.elems) }
sub harmonic-mean   (@n) { 1 / arithmetic-mean(@n.map: 1 / *) }
