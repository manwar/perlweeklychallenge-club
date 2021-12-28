#!/usr/bin/env raku
use v6;

class Vector { has @.v; method new (*@x) { self.bless(v => @x) } }
sub infix:<·> (Vector:D $x, Vector:D $y) { ($x.v »*« $y.v).sum }

sub MAIN {
   my $a = Vector.new(1, 2, 3);
   my $b = Vector.new(4, 5, 6);
   put $a · $b;
}
