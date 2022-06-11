#!/usr/bin/env raku

[\*] (1..*).grep(&is-prime)
  andthen .map(-> $product { (2..*).first({ $product + $_ andthen .is-prime }) })
  andthen .unique.head(8).sort.join(', ')
  andthen .say;
