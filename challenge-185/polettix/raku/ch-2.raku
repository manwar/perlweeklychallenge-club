#!/usr/bin/env raku
use v6;
sub MAIN {
   .put for mask-code(< ab-cde-123 123.abc.420 3abc-0010.xy
   1234567.a a-1234-bc a.b.c.d.e.f >);
}

sub mask-code (@list) {
   state %is-target = ('0' .. '9', 'a' .. 'z').flat.map: * => 1;
   @list.map: -> $s is copy {
      my ($i, $I, $n) = (0, $s.chars, 0);
      while $n < 4 && $i < $I {
         if %is-target{$s.substr($i, 1)} {
            ++$n;
            $s.substr-rw($i, 1) = 'x';
         }
         ++$i;
      }
      $s;
   };
}
