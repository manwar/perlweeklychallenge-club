#!/usr/bin/env raku
use v6;
sub MAIN (Str $input = '1 | 2 3 | 4 5') {
   if ($input.chars == 0) {
      put 0;
      return 0;
   }
   my @levels = $input.split(/\s*\|\s*/)».comb(/\S+/)».Array;
   for 1 ..^ @levels -> $depth {
      for 0 .. @levels[$depth - 1].end -> $i {
         next if (@levels[$depth - 1][$i] eq '*')
            || ((@levels[$depth][$i * 2] // '*') ne '*')
            || ((@levels[$depth][$i * 2 + 1] // '*') ne '*');
         put $depth;
         return 0;
      }
   }
   put @levels.elems;
   return 0;
}
