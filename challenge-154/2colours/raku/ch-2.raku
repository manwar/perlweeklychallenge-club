#!/usr/bin/env raku

use experimental :cached;

sub P($n) is cached {
  given ($n) {
    when 0|1|2 { 1 }
    when 3..* { P($n - 2) + P($n - 3) }
    default { Nil }
  }
}

(0..*).map(&P).grep(&is-prime).unique.head(10).say;
