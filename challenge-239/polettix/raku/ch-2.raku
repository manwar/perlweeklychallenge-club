#!/usr/bin/env raku
use v6;
sub MAIN ($allowed, *@str) { put consistent-string($allowed, @str).elems }

sub consistent-string ($allowed, @str) {
   my $al = $allowed.comb.Set;
   my &checker = sub ($input) {
      for $input.comb -> $c {
         return False unless $c ∈ $al;
      }
      return True;
   };
   @str.grep(&checker);
}
