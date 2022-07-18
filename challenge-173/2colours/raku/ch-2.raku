#!/usr/bin/env raku


(2,), { my $new = 1 + [*] .[]; (|$_, $new) } ... { $_ == 10 } andthen
  .tail
  .join: "\n" andthen
  .say;
