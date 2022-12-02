#!/usr/bin/env raku
use v6;
sub MAIN (Int:D $n where * > 0 = 2) { .put for binary-strings($n) }

sub binary-strings (Int:D $n where * > 0) {
   my $prefix = '0' x ($n - 1);
   my $i = 0;
   return gather loop {
      my $raw = ($i++).base(2).Str;
      my $len = $raw.chars;
      last if $len > $n;
      take ('0' x ($n - $len)) ~ $raw;
   };
}
